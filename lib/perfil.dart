import 'package:flutter/material.dart';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:borcelle/theme.dart';
import 'package:borcelle/menuLoginRegister.dart';
import 'package:borcelle/editarPerfil.dart';
import 'package:borcelle/editarPastel.dart';

// Configuración de URLs para diferentes entornos
class ApiConfig {
  static const bool isDevelopment = true; // Cambiar a false en producción
  
  static String get baseUrl {
    if (isDevelopment) {
      return 'http://localhost:3000'; // URL para Chrome
    } else {
      return 'https://tu-servidor-produccion.com'; // URL de producción
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Perfil',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Nunito',
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();
  
  bool _isLoading = false;
  String? _selectedImagePath;
  String? _currentImageUrl;
  bool _isEditing = false;
  bool _isExpandedPasteles = false;
  bool _isExpandedReposteros = false;

  // Lista de avatares predefinidos
  final List<String> _netflixAvatars = [
    'assets/fotodepasteles/iconoborcelle.jpg',
    'assets/fotodepasteles/pastelprimero.jpg',
    'assets/fotodepasteles/fotopastel1.jpg',
    'assets/fotodepasteles/fotopastel2.jpeg',
    'assets/fotodepasteles/fotopastel3.jpg',
    'assets/fotodepasteles/fotopastel4.jpg',
    'assets/fotodepasteles/fotopastel5.jpg',
  ];

  List<Map<String, dynamic>> _pastelesFavoritos = [
    {
      'id': '1',
      'nombre': 'Pastel de Chocolate',
      'precio': '250',
      'imagen': 'assets/fotodepasteles/pastel1.jpg',
      'descripcion': 'Delicioso pastel de chocolate con decoración especial',
      'categoria': 'Pasteles',
      'repostero': 'Juan Pérez',
      'calificacion': 4.5,
      'resenas': 12,
    },
    // Agrega más pasteles favoritos aquí
  ];

  List<Map<String, dynamic>> _reposterosFavoritos = [
    {
      'id': '1',
      'nombre': 'Juan Pérez',
      'imagen': 'assets/fotodepasteles/pastel1.jpg',
      'calificacion': 4.8,
      'resenas': 25,
      'descripcion': 'Experto en pasteles decorados',
    },
    // Agrega más reposteros favoritos aquí
  ];

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  Future<void> _cargarDatosUsuario() async {
    if (!mounted) return;
    
    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      
      if (userId == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se encontró ID de usuario'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      print('Cargando datos del usuario ID: $userId');
      print('URL del servidor: ${ApiConfig.baseUrl}');
      
      // Intentar cargar datos del servidor
      try {
        final url = '${ApiConfig.baseUrl}/api/usuario/obtenerusuario/$userId';
        print('Intentando conectar a: $url');
        
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ).timeout(
          Duration(seconds: 30),
          onTimeout: () {
            throw TimeoutException('La conexión tardó demasiado tiempo');
          },
        );

        print('Código de respuesta: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final userData = data['usuario']['usuario']; // Ajustado para la estructura correcta
          
          setState(() {
            _nombreController.text = userData['nombre'] ?? '';
            _correoController.text = userData['correo'] ?? '';
            _telefonoController.text = userData['telefono'] ?? '';
            _direccionController.text = userData['direccion'] ?? '';
            _currentImageUrl = _pastelesFavoritos[0]['imagen']; // Usar primer pastel favorito
          });
        } else {
          print('Error en la respuesta del servidor: ${response.statusCode}');
          print('URL que falló: $url');
          _cargarDatosDesdeSharedPreferences(prefs);
        }
      } catch (e) {
        print('Error al cargar datos del servidor: $e');
        print('URL que causó el error: ${ApiConfig.baseUrl}/api/usuario/obtenerusuario/$userId');
        _cargarDatosDesdeSharedPreferences(prefs);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar datos: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _cargarDatosDesdeSharedPreferences(SharedPreferences prefs) async {
    final userName = prefs.getString('userName') ?? '';
    final userEmail = prefs.getString('userEmail') ?? '';
    final userPhone = prefs.getString('userPhone') ?? '';
    final userAddress = prefs.getString('userAddress') ?? '';
    
    setState(() {
      _nombreController.text = userName;
      _correoController.text = userEmail;
      _telefonoController.text = userPhone;
      _direccionController.text = userAddress;
      _currentImageUrl = _pastelesFavoritos[0]['imagen'];
    });

    print('Datos cargados desde SharedPreferences:');
    print('Nombre: $userName');
    print('Email: $userEmail');
    print('Teléfono: $userPhone');
    print('Dirección: $userAddress');
  }

  Future<void> _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;
    if (!mounted) return;

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null) {
        throw Exception('No se encontró ID de usuario');
      }

      // Intentar guardar en el servidor
      try {
        final userData = {
          'nombre': _nombreController.text,
          'correo': _correoController.text,
          'telefono': _telefonoController.text,
          'direccion': _direccionController.text,
          'imagen_perfil': _selectedImagePath ?? _currentImageUrl,
        };

        final response = await http.put(
          Uri.parse('${ApiConfig.baseUrl}/api/usuario/actualizarusuario/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(userData),
        ).timeout(
          Duration(seconds: 30),
          onTimeout: () {
            throw TimeoutException('La conexión tardó demasiado tiempo');
          },
        );

        print('Código de respuesta al guardar: ${response.statusCode}');
        print('Respuesta del servidor al guardar: ${response.body}');

        if (response.statusCode == 200) {
          // Si el servidor responde correctamente, guardar en SharedPreferences
          await _guardarEnSharedPreferences(prefs);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Perfil actualizado exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          throw Exception('Error al actualizar el perfil: ${response.statusCode}');
        }
      } catch (e) {
        print('Error al guardar en servidor: $e');
        // Si falla el servidor, guardar solo en SharedPreferences
        await _guardarEnSharedPreferences(prefs);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Perfil actualizado localmente. Algunos cambios pueden no estar sincronizados.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar cambios: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _guardarEnSharedPreferences(SharedPreferences prefs) async {
    await prefs.setString('userName', _nombreController.text);
    await prefs.setString('userEmail', _correoController.text);
    await prefs.setString('userPhone', _telefonoController.text);
    await prefs.setString('userAddress', _direccionController.text);
    if (_selectedImagePath != null) {
      await prefs.setString('userImage', _selectedImagePath!);
    }
  }

  Future<void> _seleccionarImagen() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null && mounted) {
        setState(() {
          _selectedImagePath = image.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al seleccionar imagen: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Color(0xFFD9B9AD),
      child: ClipOval(
        child: _selectedImagePath != null
            ? Image.file(
                File(_selectedImagePath!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error cargando imagen local: $error');
                  return Icon(Icons.person, size: 50, color: Color(0xFF731D3C));
                },
              )
            : (_currentImageUrl != null
                ? Image.asset(
                    _currentImageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error cargando imagen de assets: $error');
                      return Icon(Icons.person, size: 50, color: Color(0xFF731D3C));
                    },
                  )
                : Icon(Icons.person, size: 50, color: Color(0xFF731D3C))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F0E4),
      appBar: AppBar(
        backgroundColor: Color(0xFF731D3C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Mi Perfil',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.white),
            onPressed: () {
              if (_isEditing) {
                _guardarCambios();
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        _buildProfileImage(),
                        if (_isEditing)
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFA65168),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt, color: Colors.white),
                              onPressed: _seleccionarImagen,
                            ),
                          ),
                      ],
                    ),
                    if (_isEditing) ...[
                      SizedBox(height: 20),
                      Text(
                        'Avatares Predefinidos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF731D3C),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _netflixAvatars.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImagePath = null;
                                  _currentImageUrl = _netflixAvatars[index];
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _currentImageUrl == _netflixAvatars[index]
                                        ? Color(0xFFA65168)
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    _netflixAvatars[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error cargando avatar: $error');
                                      return Icon(Icons.person, size: 40, color: Color(0xFF731D3C));
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    _buildInfoField('Nombre', _nombreController, _isEditing),
                    _buildInfoField('Correo', _correoController, _isEditing),
                    _buildInfoField('Teléfono', _telefonoController, _isEditing),
                    _buildInfoField('Dirección', _direccionController, _isEditing),
                    SizedBox(height: 20),
                    // Sección de Pasteles Favoritos
                    ExpansionTile(
                      title: Text(
                        'Pasteles Favoritos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF731D3C),
                        ),
                      ),
                      leading: Icon(Icons.cake, color: Color(0xFF731D3C)),
                      initiallyExpanded: _isExpandedPasteles,
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _isExpandedPasteles = expanded;
                        });
                      },
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _pastelesFavoritos.length,
                          itemBuilder: (context, index) {
                            final pastel = _pastelesFavoritos[index];
                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    pastel['imagen'],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error al cargar la imagen: $error');
                                      return Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                                title: Text(pastel['nombre']),
                                subtitle: Text('\$${pastel['precio']}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.favorite, color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          _pastelesFavoritos.removeAt(index);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditarPastel(pastel: pastel),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // Sección de Reposteros Favoritos
                    ExpansionTile(
                      title: Text(
                        'Reposteros Favoritos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF731D3C),
                        ),
                      ),
                      leading: Icon(Icons.person, color: Color(0xFF731D3C)),
                      initiallyExpanded: _isExpandedReposteros,
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _isExpandedReposteros = expanded;
                        });
                      },
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _reposterosFavoritos.length,
                          itemBuilder: (context, index) {
                            final repostero = _reposterosFavoritos[index];
                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(repostero['imagen']),
                                ),
                                title: Text(repostero['nombre']),
                                subtitle: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    SizedBox(width: 4),
                                    Text('${repostero['calificacion']}'),
                                    SizedBox(width: 8),
                                    Text('(${repostero['resenas']} reseñas)'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.favorite, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _reposterosFavoritos.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller, bool isEditing) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFD9B9AD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF731D3C),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          isEditing
              ? TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese $label';
                    }
                    return null;
                  },
                )
              : Text(
                  controller.text.isEmpty ? 'No especificado' : controller.text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF731D3C),
                  ),
                ),
        ],
      ),
    );
  }
}

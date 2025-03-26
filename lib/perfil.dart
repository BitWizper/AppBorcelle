import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  bool _isLoading = false;
  bool _isEditing = false;
  String? _selectedImagePath;
  String? _currentImageUrl;

  // Lista de avatares predefinidos estilo Netflix
  final List<String> _netflixAvatars = [
    'https://i.pinimg.com/736x/8d/4d/20/8d4d20b75a8d8b13e3d2907c5c58e633.jpg', // Chocolate
    'https://i.pinimg.com/736x/f2/27/f7/f227f7e5778e8f43e95624fffb1f181a.jpg', // Fresa
    'https://i.pinimg.com/736x/90/22/37/902237e139c0a842bb30c1f440547c51.jpg', // Vainilla
    'https://i.pinimg.com/736x/8c/5b/1a/8c5b1a748e005348668423ffcb5a84c8.jpg', // Almendra
    'https://i.pinimg.com/736x/8d/4d/20/8d4d20b75a8d8b13e3d2907c5c58e633.jpg', // Queso
  ];

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      
      if (userId != null) {
        final response = await http.get(
          Uri.parse("http://10.0.2.2:3000/api/usuario/obtenerusuario/$userId"),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final userData = data['usuario'];
          
          setState(() {
            _nombreController.text = userData['nombre'] ?? '';
            _correoController.text = userData['correo'] ?? '';
            _telefonoController.text = userData['telefono'] ?? '';
            _direccionController.text = userData['direccion'] ?? '';
            _currentImageUrl = userData['imagen_perfil'] ?? _netflixAvatars[0];
          });
        }
      }
    } catch (e) {
      print('Error al cargar datos: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId != null) {
        final userData = {
          "nombre": _nombreController.text,
          "correo": _correoController.text,
          "telefono": _telefonoController.text,
          "direccion": _direccionController.text,
          "imagen_perfil": _selectedImagePath ?? _currentImageUrl,
        };

        final response = await http.put(
          Uri.parse("http://10.0.2.2:3000/api/usuario/actualizarusuario/$userId"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(userData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Perfil actualizado exitosamente"),
              backgroundColor: Colors.green,
            ),
          );
          
          // Actualizar SharedPreferences
          await prefs.setString('userName', _nombreController.text);
          await prefs.setString('userEmail', _correoController.text);
          await prefs.setString('userPhone', _telefonoController.text);
          await prefs.setString('userAddress', _direccionController.text);
          if (_selectedImagePath != null) {
            await prefs.setString('userImage', _selectedImagePath!);
          }
        } else {
          throw Exception("Error al actualizar el perfil");
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al guardar los cambios"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F0E4),
      appBar: AppBar(
        backgroundColor: Color(0xFF731D3C),
        title: Text(
          "Mi Perfil",
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
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _selectedImagePath != null
                              ? FileImage(File(_selectedImagePath!))
                              : (_currentImageUrl != null
                                  ? NetworkImage(_currentImageUrl!) as ImageProvider
                                  : AssetImage("assets/fotodepasteles/iconoborcelle.jpg")),
                        ),
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
                        "Avatares Predefinidos",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF731D3C),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
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
                                  image: DecorationImage(
                                    image: NetworkImage(_netflixAvatars[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    _buildInfoField("Nombre", _nombreController, _isEditing),
                    _buildInfoField("Correo", _correoController, _isEditing),
                    _buildInfoField("Teléfono", _telefonoController, _isEditing),
                    _buildInfoField("Dirección", _direccionController, _isEditing),
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
                  controller.text.isEmpty ? "No especificado" : controller.text,
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

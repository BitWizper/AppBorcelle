import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  // Variables para almacenar datos del perfil
  String profileName = "Nombre del Usuario";
  String profileBio = "Descripción breve del usuario.";
  String profileImage = "assets/user-placeholder.jpg";

  // Controladores de formularios
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  bool _isEditing = false;

  // Listas de favoritos y pedidos
  List<Map<String, dynamic>> favoritosPasteles = [
    {
      'nombre': 'Pastel de Chocolate',
      'imagen': 'assets/fotodepasteles/pastelferrero.jpg',
      'precio': '\$450',
      'repostero': 'Ana García'
    },
    {
      'nombre': 'Pastel de Fresa',
      'imagen': 'assets/fotodepasteles/pasteldemandarina.png',
      'precio': '\$380',
      'repostero': 'Carlos López'
    },
  ];

  List<Map<String, dynamic>> favoritosReposteros = [
    {
      'nombre': 'Ana García',
      'imagen': 'assets/fotodepasteles/iconoborcelle.jpg',
      'especialidad': 'Pasteles de Chocolate',
      'calificacion': 4.8
    },
    {
      'nombre': 'Carlos López',
      'imagen': 'assets/fotodepasteles/iconoborcelle.jpg',
      'especialidad': 'Pasteles de Frutas',
      'calificacion': 4.9
    },
  ];

  List<Map<String, dynamic>> pedidos = [
    {
      'nombre': 'Pastel de Chocolate',
      'fecha': '15/03/2024',
      'estado': 'Entregado',
      'precio': '\$450',
      'repostero': 'Ana García',
      'imagen': 'assets/fotodepasteles/pastelferrero.jpg'
    },
    {
      'nombre': 'Pastel de Fresa',
      'fecha': '10/03/2024',
      'estado': 'Entregado',
      'precio': '\$380',
      'repostero': 'Carlos López',
      'imagen': 'assets/fotodepasteles/pasteldemandarina.png'
    },
    {
      'nombre': 'Pastel de Vainilla',
      'fecha': '05/03/2024',
      'estado': 'Entregado',
      'precio': '\$350',
      'repostero': 'María Rodríguez',
      'imagen': 'assets/fotodepasteles/pastelprimero.jpg'
    },
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = profileName;
    _bioController.text = profileBio;
    _cargarDatosUsuario();
  }

  void _cargarDatosUsuario() {
    // Simulación de carga de datos
    _nameController.text = "Juan Pérez";
    _emailController.text = "juan.perez@email.com";
    _telefonoController.text = "123-456-7890";
    _direccionController.text = "Calle Principal #123";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  // Función para actualizar la información
  void _updateProfile() {
    setState(() {
      profileName = _nameController.text;
      profileBio = _bioController.text;
    });
    Navigator.of(context).pop();
  }

  // Función para mostrar las secciones del perfil
  void _showSection(String section) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        switch (section) {
          case 'editarPerfil':
            return _buildEditProfileSection();
          case 'notificaciones':
            return _buildNotificacionesSection();
          case 'miTarjeta':
            return _buildMiTarjetaSection();
          case 'configuracion':
            return _buildConfiguracionSection();
          default:
            return SizedBox();
        }
      },
    );
  }

  // Métodos para cada sección
  Widget _buildEditProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Editar Perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Nombre:', style: TextStyle(fontSize: 16)),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Escribe tu nombre'),
          ),
          SizedBox(height: 16),
          Text('Biografía:', style: TextStyle(fontSize: 16)),
          TextField(
            controller: _bioController,
            decoration: InputDecoration(hintText: 'Escribe tu biografía'),
            maxLines: 4,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _updateProfile,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            child: Text('Actualizar Información'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificacionesSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Recibe alertas sobre actividades importantes y actualizaciones.'),
    );
  }

  Widget _buildMiTarjetaSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Gestiona tus métodos de pago y tarjetas de crédito aquí.'),
    );
  }

  Widget _buildConfiguracionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Ajusta tus preferencias de cuenta y configuración general.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        title: Text(
          "Mi Perfil",
          style: GoogleFonts.lora(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.white),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto de perfil
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 2),
                      image: DecorationImage(
                        image: AssetImage('assets/fotodepasteles/iconoborcelle.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFF8C1B2F),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Información personal
            _buildProfileSection(
              "Información Personal",
              Column(
                children: [
                  _buildTextField("Nombre", _nameController),
                  _buildTextField("Email", _emailController),
                  _buildTextField("Teléfono", _telefonoController),
                  _buildTextField("Dirección", _direccionController),
                ],
              ),
            ),

            // Favoritos (Desplegable)
            Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF2F0E4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
              ),
              child: ExpansionTile(
                title: Text(
                  "Mis Favoritos",
                  style: GoogleFonts.lora(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8C1B2F),
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildFavoritosSection("Pasteles Favoritos", favoritosPasteles, true),
                        SizedBox(height: 16),
                        _buildFavoritosSection("Reposteros Favoritos", favoritosReposteros, false),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Historial de pedidos (Desplegable)
            Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF2F0E4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
              ),
              child: ExpansionTile(
                title: Text(
                  "Historial de Pedidos",
                  style: GoogleFonts.lora(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8C1B2F),
                  ),
                ),
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: pedidos.map((pedido) => _buildOrderItem(pedido)).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Preferencias
            _buildProfileSection(
              "Preferencias",
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text("Notificaciones", style: TextStyle(color: Color(0xFF8C1B2F))),
                      value: true,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: Text("Boletín de ofertas", style: TextStyle(color: Color(0xFF8C1B2F))),
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, Widget content) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF2F0E4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lora(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C1B2F),
            ),
          ),
          SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFFA65168)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFA65168).withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFA65168)),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        style: TextStyle(color: Color(0xFF8C1B2F)),
      ),
    );
  }

  Widget _buildFavoritosSection(String title, List<Map<String, dynamic>> items, bool isPastel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lora(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8C1B2F),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        item['imagen'],
                        height: 80,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['nombre'],
                            style: TextStyle(
                              color: Color(0xFF8C1B2F),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isPastel) ...[
                            Text(
                              item['precio'],
                              style: TextStyle(
                                color: Color(0xFFA65168),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              item['repostero'],
                              style: TextStyle(
                                color: Color(0xFFA65168).withOpacity(0.8),
                                fontSize: 10,
                              ),
                            ),
                          ] else ...[
                            Text(
                              item['especialidad'],
                              style: TextStyle(
                                color: Color(0xFFA65168),
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Color(0xFFA65168), size: 12),
                                SizedBox(width: 4),
                                Text(
                                  item['calificacion'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFFA65168),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> pedido) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFA65168).withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              pedido['imagen'],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pedido['nombre'],
                  style: TextStyle(
                    color: Color(0xFF8C1B2F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  pedido['repostero'],
                  style: TextStyle(
                    color: Color(0xFFA65168),
                    fontSize: 12,
                  ),
                ),
                Text(
                  pedido['fecha'],
                  style: TextStyle(
                    color: Color(0xFFA65168).withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                pedido['precio'],
                style: TextStyle(
                  color: Color(0xFF8C1B2F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFA65168).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pedido['estado'],
                  style: TextStyle(
                    color: Color(0xFFA65168),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

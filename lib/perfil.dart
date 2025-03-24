import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _nameController.text = profileName;
    _bioController.text = profileBio;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
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
        title: Text('Mi Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto de perfil
              Center(
                child: ClipOval(
                  child: Image.asset(
                    profileImage,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(profileName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(profileBio, style: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
              SizedBox(height: 32),
              // Botones para secciones
              _buildProfileOption('Editar Perfil', 'editarPerfil'),
              _buildProfileOption('Notificaciones', 'notificaciones'),
              _buildProfileOption('Mi Tarjeta', 'miTarjeta'),
              _buildProfileOption('Configuración', 'configuracion'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, String section) {
    return ElevatedButton(
      onPressed: () => _showSection(section),
      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.pink),
      child: Text(title),
    );
  }

  Widget _buildProfileSection(String title, Widget content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
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
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFA65168), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFA65168).withOpacity(0.5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFA65168), width: 2),
        ),
      ),
    );
  }
}

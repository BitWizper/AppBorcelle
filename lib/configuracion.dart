import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Configuración',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Nunito',
      ),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Controladores para los formularios
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedLanguage = 'es';
  bool _emailNotifications = false;
  bool _showProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración de Cuenta'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón de regreso
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.pink[300],
                  size: 30,
                ),
              ),
              SizedBox(height: 20),
              // Título
              Center(
                child: Text(
                  'Configuración de Cuenta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[300],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Cambiar Contraseña
              _buildSectionTitle('Cambiar Contraseña'),
              _buildTextField('Contraseña Actual', _currentPasswordController, true),
              _buildTextField('Nueva Contraseña', _newPasswordController, true),
              _buildTextField('Confirmar Nueva Contraseña', _confirmPasswordController, true),
              _buildButton('Actualizar Contraseña'),

              // Preferencias de Idioma
              _buildSectionTitle('Idioma'),
              _buildDropdown(),
              _buildButton('Guardar Preferencias'),

              // Preferencias de Privacidad
              _buildSectionTitle('Privacidad'),
              _buildCheckbox('Recibir Notificaciones por Correo Electrónico', _emailNotifications, (value) {
                setState(() {
                  _emailNotifications = value!;
                });
              }),
              _buildCheckbox('Mostrar mi perfil públicamente', _showProfile, (value) {
                setState(() {
                  _showProfile = value!;
                });
              }),
              _buildButton('Actualizar Preferencias de Privacidad'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para los campos de texto (contraseña)
  Widget _buildTextField(String label, TextEditingController controller, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  // Widget para el selector de idioma (Dropdown)
  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedLanguage,
        items: [
          DropdownMenuItem(value: 'es', child: Text('Español')),
          DropdownMenuItem(value: 'en', child: Text('Inglés')),
          DropdownMenuItem(value: 'fr', child: Text('Francés')),
          DropdownMenuItem(value: 'de', child: Text('Alemán')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedLanguage = value!;
          });
        },
        decoration: InputDecoration(
          labelText: 'Seleccionar Idioma',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  // Widget para las casillas de verificación (checkbox)
  Widget _buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.pink[300],
          ),
          Text(label),
        ],
      ),
    );
  }

  // Widget para el botón de acción
  Widget _buildButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Implementar la acción del botón (por ejemplo, enviar los datos a un servidor)
          print('Acción: $label');
        },
        child: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[300],
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Widget para el título de cada sección
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.pink[300],
        ),
      ),
    );
  }
}

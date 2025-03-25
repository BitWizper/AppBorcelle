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
      title: 'Configuración',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Lora', // Cambié la tipografía a Lora
      ),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Controladores para los formularios
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedLanguage = 'es';
  final bool _emailNotifications = false;
  final bool _showProfile = false;
  bool notificaciones = false;
  bool modoOscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        title: Text(
          "Configuración",
          style: GoogleFonts.lora(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preferencias",
                style: GoogleFonts.lora(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1B2F),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F0E4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(
                        "Notificaciones",
                        style: TextStyle(color: Color(0xFF8C1B2F)),
                      ),
                      value: notificaciones,
                      onChanged: (bool value) {
                        setState(() {
                          notificaciones = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: Text(
                        "Modo Oscuro",
                        style: TextStyle(color: Color(0xFF8C1B2F)),
                      ),
                      value: modoOscuro,
                      onChanged: (bool value) {
                        setState(() {
                          modoOscuro = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Cuenta",
                style: GoogleFonts.lora(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1B2F),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F0E4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.lock, color: Color(0xFF8C1B2F)),
                      title: Text(
                        "Cambiar Contraseña",
                        style: TextStyle(color: Color(0xFF8C1B2F)),
                      ),
                      onTap: () {
                        // Implementar cambio de contraseña
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.delete, color: Color(0xFF8C1B2F)),
                      title: Text(
                        "Eliminar Cuenta",
                        style: TextStyle(color: Color(0xFF8C1B2F)),
                      ),
                      onTap: () {
                        // Implementar eliminación de cuenta
                      },
                    ),
                  ],
                ),
              ),
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
      ),
    );
  }

  // Widget para las casillas de verificación (checkbox)
  Widget _buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Color(0xFF8C1B2F), // Vino oscuro
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Color(0xFFA65168).withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
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
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8C1B2F), // Vino oscuro
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Color(0xFFA65168), width: 1),
          ),
        ),
        child: Text(label),
      ),
    );
  }

  // Widget para el título de cada sección
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8C1B2F), // Vino oscuro
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF8C1B2F),
        scaffoldBackgroundColor: Color(0xFFF2F0E4),
      ),
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F0E4),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fotodepasteles/pastelprimero.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/fotodepasteles/iconoborcelle.jpg"),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF8C1B2F).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Borcelle",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildButton(context, "Iniciar Sesión", true),
                      SizedBox(height: 15),
                      _buildButton(context, "Registrarse", false),
                      SizedBox(height: 20),
                      Text(
                        "O continúa con",
                        style: TextStyle(
                          color: Color(0xFF8C1B2F),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            icon: FontAwesomeIcons.google,
                            color: Colors.red,
                            onPressed: () => _handleGoogleSignIn(),
                          ),
                          SizedBox(width: 20),
                          _buildSocialButton(
                            icon: FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            onPressed: () => _handleFacebookSignIn(),
                          ),
                          SizedBox(width: 20),
                          _buildSocialButton(
                            icon: FontAwesomeIcons.phone,
                            color: Colors.green,
                            onPressed: () => _handlePhoneSignIn(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, bool isLogin) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFA65168),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 18),
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 8,
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Color(0xFF731D3C);
          }
          return null;
        }),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormScreen(role: "Cliente", isLogin: isLogin)),
        );
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: FaIcon(icon, color: color),
        onPressed: onPressed,
        iconSize: 24,
      ),
    );
  }

  void _handleGoogleSignIn() {
    // Implementar inicio de sesión con Google
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Inicio de sesión con Google")),
    );
  }

  void _handleFacebookSignIn() {
    // Implementar inicio de sesión con Facebook
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Inicio de sesión con Facebook")),
    );
  }

  void _handlePhoneSignIn() {
    // Implementar inicio de sesión con teléfono
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Inicio de sesión con teléfono")),
    );
  }
}

class FormScreen extends StatefulWidget {
  final String role;
  final bool isLogin;
  const FormScreen({super.key, required this.role, required this.isLogin});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  bool _mostrarContrasena = false;

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final loginData = {
        "correo": _correoController.text,
        "contrasena": _contrasenaController.text,
        "tipo_usuario": "Cliente",
      };

      final response = await http.post(
        Uri.parse("http://localhost:3000/api/usuario/loginuser"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(loginData),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data["token"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión exitoso"),
            backgroundColor: Colors.green,
          ),
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        _mostrarErrorDialog("Usuario o contraseña incorrectos");
      }
    } catch (e) {
      _mostrarErrorDialog("Error de conexión. Por favor, intente nuevamente.");
    }
  }

  Future<void> _registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final registroData = {
        "userData": {
          "nombre": _nombreController.text,
          "correo": _correoController.text,
          "contrasena": _contrasenaController.text,
          "direccion": _direccionController.text,
          "telefono": _telefonoController.text,
          "tipo_usuario": "Cliente"
        }
      };

      final response = await http.post(
        Uri.parse("http://localhost:3000/api/usuario/crearusuarios"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(registroData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registro exitoso"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Volver a la pantalla de login
      } else {
        final data = json.decode(response.body);
        _mostrarErrorDialog(data["error"] ?? "Error al registrar usuario");
      }
    } catch (e) {
      _mostrarErrorDialog("Error de conexión. Por favor, intente nuevamente.");
    }
  }

  void _mostrarErrorDialog(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF2F0E4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Color(0xFF8C1B2F)),
              SizedBox(width: 10),
              Text(
                "Error",
                style: TextStyle(
                  color: Color(0xFF8C1B2F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            mensaje,
            style: TextStyle(
              color: Color(0xFF731D3C),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _contrasenaController.clear();
              },
              child: Text(
                "Aceptar",
                style: TextStyle(
                  color: Color(0xFFA65168),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F0E4),
      appBar: AppBar(
        backgroundColor: Color(0xFF731D3C),
        title: Text(
          widget.isLogin ? "Iniciar Sesión" : "Registro",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!widget.isLogin) ...[
                  _buildTextField("Nombre", _nombreController),
                  _buildTextField("Dirección", _direccionController),
                  _buildTextField("Teléfono", _telefonoController),
                ],
                _buildTextField("Correo", _correoController),
                _buildTextField("Contraseña", _contrasenaController, obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA65168),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 18),
                    shadowColor: Colors.black.withOpacity(0.4),
                    elevation: 8,
                  ).copyWith(
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Color(0xFF731D3C);
                      }
                      return null;
                    }),
                  ),
                  onPressed: widget.isLogin ? _loginUser : _registrarUsuario,
                  child: Text(
                    widget.isLogin ? "Iniciar Sesión" : "Crear Cuenta",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFD9B9AD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText && !_mostrarContrasena,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF731D3C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFFD9B9AD),
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    _mostrarContrasena ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFF731D3C),
                  ),
                  onPressed: () {
                    setState(() {
                      _mostrarContrasena = !_mostrarContrasena;
                    });
                  },
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $label';
          }
          if (label == "Contraseña" && value.length < 6) {
            return 'La contraseña debe tener al menos 6 caracteres';
          }
          return null;
        },
      ),
    );
  }
}

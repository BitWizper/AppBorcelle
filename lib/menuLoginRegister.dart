import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences

import 'home.dart';
import 'repostero_home.dart';

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
        primaryColor: Colors.amberAccent,
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
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Verifica el estado del login almacenado en SharedPreferences
  _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fotodepasteles/pastelprimero.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Borcelle",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Solo muestra el botón de "Iniciar Sesión" si el usuario no está logueado
              if (!_isLoggedIn)
                _buildButton(context, "Iniciar Sesión", true),
              SizedBox(height: 15),
              _buildButton(context, "Registrarse", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, bool isLogin) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFA65168), // Rosa oscuro elegante
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 18),
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 8,
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Color(0xFF731D3C); // Cambia al presionar
          }
          return null;
        }),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoleSelectionScreen(isLogin: isLogin)),
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
}

class RoleSelectionScreen extends StatelessWidget {
  final bool isLogin;
  const RoleSelectionScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selecciona tu Rol")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleButton(context, "Clientes", "Cliente"),
            SizedBox(height: 15),
            _buildRoleButton(context, "Reposteros", "Repostero"),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String text, String role) {
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
          MaterialPageRoute(builder: (context) => FormScreen(role: role, isLogin: isLogin)),
        );
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
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

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    final loginData = {
      "correo": _correoController.text,
      "contrasena": _contrasenaController.text,
      "tipo_usuario": widget.role,
    };

    final response = await http.post(
      Uri.parse("http://localhost:3000/api/usuario/loginuser"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(loginData),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200 && data["token"] != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inicio de sesión exitoso")));

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);  // Guarda el estado de sesión

      if (widget.role == "Cliente") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (widget.role == "Repostero") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReposteroHomeScreen()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data["error"] ?? "Error en el inicio de sesión")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.isLogin ? "Iniciar Sesión" : "Registro"} - ${widget.role}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                onPressed: widget.isLogin ? _loginUser : null, // Aquí puedes agregar _registerUser si es necesario
                child: Text(
                  widget.isLogin ? "Iniciar Sesión" : "Crear Cuenta",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

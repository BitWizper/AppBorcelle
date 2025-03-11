import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Borcelle", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            _buildButton(context, "Iniciar Sesión", true),
            SizedBox(height: 15),
            _buildButton(context, "Registrarse", false),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, bool isLogin) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoleSelectionScreen(isLogin: isLogin)),
        );
      },
      child: Text(text, style: TextStyle(fontSize: 18)),
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormScreen(role: role, isLogin: isLogin)),
        );
      },
      child: Text(text, style: TextStyle(fontSize: 18)),
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
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _negocioController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _especialidadesController = TextEditingController();

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    final userData = {
      "nombre": _nombreController.text,
      "correo": _correoController.text,
      "contrasena": _contrasenaController.text,
      "direccion": _direccionController.text,
      "telefono": _telefonoController.text,
      "tipo_usuario": widget.role,
    };

    final reposteroData = widget.role == "Repostero"
        ? {
            "NombreNegocio": _negocioController.text,
            "Ubicacion": _ubicacionController.text,
            "Especialidades": _especialidadesController.text,
          }
        : null;

    final body = widget.role == "Repostero"
        ? json.encode({"userData": userData, "reposteroData": reposteroData})
        : json.encode({"userData": userData});

    final response = await http.post(
      Uri.parse(widget.role == "Repostero"
          ? "http://localhost:3000/api/repostero/creareposteros"
          : "http://localhost:3000/api/usuario/crearusuarios"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registro exitoso")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data["error"] ?? "Error en el registro")));
    }
  }

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

      // Redirigir a la pantalla correspondiente
      if (widget.role == "Cliente") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // Cliente
        );
      } else if (widget.role == "Repostero") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ReposteroHomeScreen()), // Repostero
        );
      }
      // Guardar token si es necesario
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
              if (!widget.isLogin) ...[
                _buildTextField("Nombre", _nombreController),
                _buildTextField("Teléfono", _telefonoController),
                _buildTextField("Dirección", _direccionController),
                if (widget.role == "Repostero") ...[
                  _buildTextField("Nombre del Negocio", _negocioController),
                  _buildTextField("Ubicación", _ubicacionController),
                  _buildTextField("Especialidades", _especialidadesController),
                ],
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.isLogin ? _loginUser : _registerUser,
                child: Text(widget.isLogin ? "Iniciar Sesión" : "Crear Cuenta"),
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

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(RegisterReposteroApp());
}

class RegisterReposteroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Repostero',
      theme: ThemeData(
        primaryColor: Color(0xFFA63D40),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterReposteroPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 150),
            SizedBox(height: 20),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA63D40))),
            SizedBox(height: 20),
            Text("Cargando... Por favor, espere", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class RegisterReposteroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Registro de Repostero", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA63D40))),
              SizedBox(height: 20),
              _buildTextField("Nombre"),
              _buildTextField("Correo"),
              _buildTextField("Contraseña (8 caracteres)", obscureText: true),
              _buildTextField("Dirección"),
              _buildTextField("Teléfono (10 dígitos)"),
              SizedBox(height: 20),
              Text("Información del Negocio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFA63D40))),
              SizedBox(height: 10),
              _buildTextField("Nombre del Negocio"),
              _buildTextField("Ubicación"),
              _buildTextField("Especialidades", maxLines: 3),
              _buildTextField("URL del Portafolio (opcional)"),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA63D40),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {},
                child: Text("Crear Cuenta", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {},
                child: Text("¿Ya tienes una cuenta? Inicia sesión", style: TextStyle(fontSize: 16, color: Color(0xFFA63D40))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, {bool obscureText = false, int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

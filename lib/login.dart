import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  // ... (existing code)
}

class _LoginScreenState extends State<LoginScreen> {
  // ... (existing code)

  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/usuario/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', data['_id']);
        await prefs.setString('userName', data['nombre']);
        await prefs.setString('userEmail', data['email']);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al iniciar sesión. Verifica tus credenciales.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al conectar con el servidor.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ... (rest of the existing code)
} 
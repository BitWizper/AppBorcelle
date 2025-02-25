import 'package:flutter/material.dart';

class RegisterClienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFFA63D40)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Text(
                'Crear Cuenta',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA63D40),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(label: 'Nombre'),
              _buildTextField(label: 'Correo', keyboardType: TextInputType.emailAddress),
              _buildTextField(label: 'Contraseña', obscureText: true),
              _buildTextField(label: 'Dirección'),
              _buildTextField(label: 'Teléfono', keyboardType: TextInputType.phone),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA63D40),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: Text('Crear Cuenta', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text('¿Ya tienes una cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterClienteScreen(),
  ));
}

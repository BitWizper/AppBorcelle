import 'package:flutter/material.dart'; // Asegúrate de que la ruta es correcta
// Asegúrate de que la ruta es correcta
import 'package:borcelle/home.dart';

void main() {
  runApp(SelectRegisterApp());
}

class SelectRegisterApp extends StatelessWidget {
  const SelectRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Aquí está la pantalla principal
    );
    
  }
}

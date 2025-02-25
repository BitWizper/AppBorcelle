import 'package:borcelle/SelectRegisterScreen.dart';
import 'package:flutter/material.dart';
import 'select_register_screen.dart'; // Asegúrate de que la ruta es correcta


void main() {
  runApp(SelectRegisterApp());
}

class SelectRegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectRegisterScreen(), // Aquí está la pantalla principal
    );
  }
}

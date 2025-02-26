//import 'package:borcelle/SelectRegisterScreen.dart';
import 'package:flutter/material.dart'; // Asegúrate de que la ruta es correcta
import 'package:borcelle/menuLoginRegister.dart';


void main() {
  runApp(SelectRegisterApp());
}

class SelectRegisterApp extends StatelessWidget {
  const SelectRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(), // Aquí está la pantalla principal
    );
  }
}

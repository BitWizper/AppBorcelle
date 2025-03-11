import 'package:flutter/material.dart';
import 'package:borcelle/home.dart'; // Asegúrate de importar el archivo de Home
import 'package:borcelle/menuLoginRegister.dart'; // Asegúrate de importar este archivo para la pantalla de login/register
// Importa otros archivos de pantalla como perfil, pedidos, etc.

void main() {
  runApp(SelectRegisterApp());
}

class SelectRegisterApp extends StatelessWidget {
  const SelectRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', // Ruta inicial
      routes: {
        '/home': (context) => HomeScreen(), // Ruta para la pantalla de inicio
        '/menuLoginRegister': (context) => AuthScreen(), // Ruta para la pantalla de login/register
        // Agrega aquí las demás rutas para otras pantallas
      },
    );
  }
}

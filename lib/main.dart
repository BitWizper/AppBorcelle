import 'package:borcelle/categorias.dart';
import 'package:flutter/material.dart'; // Asegúrate de que la ruta es correcta
import 'package:borcelle/menuLoginRegister.dart'; // Asegúrate de que la ruta es correcta


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
      routes: {
        '/home': (context) => HomeScreen(), // Pantalla de inicio
        '/catalogo_pasteles': (context) => CatalogScreen(), // Pantalla de catálogo de pasteles
        '/catalogo_reposteros': (context) => CatalogoReposterosScreen(), // Pantalla de catálogo de reposteros
        '/crear_pastel': (context) => CrearPastelScreen(), // Pantalla para crear un pastel
      },
    );
  }
}

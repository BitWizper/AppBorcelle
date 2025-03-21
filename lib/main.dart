import 'package:flutter/material.dart';
import 'package:borcelle/home.dart'; // Pantalla de inicio
import 'package:borcelle/menuLoginRegister.dart'; // Pantalla de login/register
import 'package:borcelle/categorias.dart'; // Pantalla de categorias
import 'package:borcelle/reposteros.dart'; // Pantalla de reposteros
import 'package:borcelle/ayuda.dart'; // Pantalla de ayuda
import 'package:borcelle/perfil.dart'; // Pantalla de perfil
import 'package:borcelle/configuracion.dart'; // pantalla de configuracion
import 'package:borcelle/pedidos.dart'; // Pantalla de pedidos
// Asegúrate de importar otras pantallas si las tienes

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
        '/inicio': (context) => HomeScreen(), // Ruta para la pantalla de inicio
        '/categorias': (context) => CategoriasScreen (), // Ruta para la pantalla de categorias 
        '/reposteros': (context) => ReposterosScreen(), // ruta de pantalla de reposteros 
        '/menuLoginRegister': (context) => AuthScreen(), // Ruta para la pantalla de login/register
        '/ayuda': (context) => HelpScreen(), // Ruta para la pantalla de ayuda
       '/configuracion': (context) => SettingsScreen (), // Ruta para la pantalla de ayuda
        '/perfil': (context) => ProfileScreen(), // Ruta para la pantalla de perfil
        '/registro': (context) => RegisterScreen(), // Ruta para la pantalla de registro
        '/pedidos': (context) => OrdersScreen(), // Ruta para la pantalla de registro
        // Aquí puedes agregar otras rutas para las pantallas que falten
      },
    );
  }
}

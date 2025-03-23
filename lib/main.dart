import 'package:flutter/material.dart';
import 'package:borcelle/home.dart' as home; // Pantalla de inicio
import 'package:borcelle/menuLoginRegister.dart'; // Pantalla de login/register
import 'package:borcelle/categorias.dart' as categorias; // Pantalla de categorias
import 'package:borcelle/reposteros.dart' as reposteros; // Pantalla de reposteros
import 'package:borcelle/ayuda.dart'; // Pantalla de ayuda
import 'package:borcelle/perfil.dart'; // Pantalla de perfil
import 'package:borcelle/configuracion.dart'; // pantalla de configuracion
import 'package:borcelle/pedidos.dart'; // Pantalla de pedidos
import 'package:borcelle/Model3D/MainMenuUI.dart'; // Pantalla de modelo 3D
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
      initialRoute: '/inicio', // Asegúrate de que coincide con las rutas definidas
      routes: {
        '/inicio': (context) => home.HomeScreen(),
        '/categorias': (context) => categorias.CategoriasScreen(),
        '/reposteros': (context) => reposteros.ReposterosScreen(),
        '/menuLoginRegister': (context) => AuthScreen(),
        '/ayuda': (context) => HelpScreen(),
        '/configuracion': (context) => SettingsScreen(),
        '/perfil': (context) => ProfileScreen(),
        '/registro': (context) => RegisterScreen(),
        '/pedidos': (context) => OrdersScreen(),
        '/model3d': (context) => Model3DViewer(),
      },
    );
  }
}

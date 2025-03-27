import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:borcelle/theme.dart' as app_theme;
import 'package:borcelle/home.dart' as home; // Pantalla de inicio
import 'package:borcelle/menuLoginRegister.dart'; // Pantalla de login/register
import 'package:borcelle/categorias.dart'; // Pantalla de categorias
import 'package:borcelle/reposteros.dart'; // Pantalla de reposteros
import 'package:borcelle/ayuda.dart'; // Pantalla de ayuda
import 'package:borcelle/perfil.dart'; // Pantalla de perfil
import 'package:borcelle/configuracion.dart'; // pantalla de configuracion
import 'package:borcelle/pedidos.dart'; // Pantalla de pedidos
import 'package:borcelle/Model3D/MainMenuUI.dart'; // Pantalla de modelo 3D
import 'package:borcelle/notifications.dart';
// Asegúrate de importar otras pantallas si las tienes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar notificaciones
  await NotificationService().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  app_theme.AppThemeMode _currentTheme = app_theme.AppThemeMode.light;

  @override
  void initState() {
    super.initState();
    _cargarTema();
  }

  Future<void> _cargarTema() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentTheme = app_theme.AppThemeMode.values[prefs.getInt('themeMode') ?? 0];
    });
  }

  void _actualizarTema(app_theme.AppThemeMode nuevoTema) {
    setState(() {
      _currentTheme = nuevoTema;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Borcelle',
      theme: app_theme.AppTheme.getTheme(_currentTheme),
      darkTheme: app_theme.AppTheme.getTheme(app_theme.AppThemeMode.dark),
      themeMode: _currentTheme == app_theme.AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/home',
      builder: (context, child) {
        return Theme(
          data: app_theme.AppTheme.getTheme(_currentTheme),
          child: child!,
        );
      },
      routes: {
        '/home': (context) => const home.HomeScreen(),
        '/categorias': (context) => const CategoriasScreen(),
        '/reposteros': (context) => const ReposterosScreen(),
        '/menuLoginRegister': (context) => const AuthScreen(),
        '/ayuda': (context) => const HelpScreen(),
        '/configuracion': (context) => ConfiguracionScreen(
          onThemeChanged: _actualizarTema,
        ),
        '/perfil': (context) => const ProfileScreen(),
        '/registro': (context) => const RegisterScreen(),
        '/pedidos': (context) => const OrdersScreen(),
        '/crearPastel': (context) => const Model3DViewer(),
      },
    );
  }
}

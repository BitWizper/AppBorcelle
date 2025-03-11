import 'package:flutter/material.dart';
import 'Home.dart';         // HomeScreen
import 'Perfil.dart';     // ProfileScreen
import 'pedidos.dart';      // OrdersScreen
import 'ayuda.dart';        // HelpScreen
import 'configuracion.dart';    // SettingsScreen
import 'categorias.dart';  // CategoriasScreen
import 'reposteros.dart';  // ReposterosScreen
import 'menuLoginRegister.dart';        // AuthScreen

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomeScreen(),
      '/perfil': (context) => ProfileScreen(),
      '/pedidos': (context) => OrdersScreen(),
      '/ayuda': (context) => HelpScreen(),
      '/configuracion': (context) => SettingsScreen(),
      '/categorias': (context) => CategoriasScreen(),
      '/reposteros': (context) => ReposterosScreen(),
      '/login': (context) => AuthScreen(),
    },
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false; // Variable para verificar si está autenticado
  String userType = ""; // Variable para verificar el tipo de usuario: "cliente" o "repostero"

  void _onItemTapped(int index) {
    String route;
    switch (index) {
      case 0:
        route = '/home';
        break;
      case 1:
        route = '/categorias';
        break;
      case 2:
        route = '/reposteros';
        break;
      case 3:
        route = '/crearPastel';
        break;
      default:
        return;
    }

    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context, rootNavigator: true).pushNamed(route);
  }

  Future<void> cerrarSesion() async {
    setState(() {
      _isLoggedIn = false;
      userType = ""; // Restablece el tipo de usuario al cerrar sesión
    });
    print("Sesión cerrada correctamente");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar pasteles...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (!_isLoggedIn)
            TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
                if (result != null) {
                  setState(() {
                    _isLoggedIn = true; 
                    userType = result; // Asigna el tipo de usuario
                  });
                  if (result == "cliente" || result == "repostero") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TipoUsuarioScreen(userType: result),
                      ),
                    );
                  }
                }
              },
              child: Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Cerrar Sesión') {
                _mostrarDialogoCerrarSesion(context);
              } else {
                Navigator.of(context, rootNavigator: true).pushNamed(value);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: '/perfil', child: Text('Mi Perfil')),
                PopupMenuItem(value: '/pedidos', child: Text('Mis Pedidos')),
                PopupMenuItem(value: '/ayuda', child: Text('Centro de Ayuda')),
                PopupMenuItem(value: '/configuracion', child: Text('Configuración')),
                if (_isLoggedIn)
                  PopupMenuItem(
                    value: 'Cerrar Sesión',
                    child: Text('Cerrar Sesión'),
                  ),
              ];
            },
          ),
        ],
      ),
      body: Center(child: Text('Contenido de la HomeScreen')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Pasteles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Reposteros',
          ),
          if (userType == "repostero")
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Crear Pastel',
            ),
        ],
      ),
    );
  }

  void _mostrarDialogoCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cerrar Sesión'),
        content: Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isLoggedIn = false;
                userType = ""; // Resetea el tipo de usuario
              });
              Navigator.of(context).pop();
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = true;

  Future<String> _loginUsuario(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://tu-api.com/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['tipo_usuario']; // Devuelve "cliente" o "repostero"
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  void _submit() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      _loginUsuario(email, password).then((userType) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TipoUsuarioScreen(userType: userType),
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al iniciar sesión: $error')));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, ingresa tus credenciales')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Iniciar Sesión" : "Registrar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(isLogin ? 'Iniciar Sesión' : 'Registrar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin ? '¿No tienes cuenta? Regístrate' : '¿Ya tienes cuenta? Inicia sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class TipoUsuarioScreen extends StatelessWidget {
  final String userType;
  const TipoUsuarioScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecciona tu rol')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido, eres $userType'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Ir al menú principal'),
            ),
          ],
        ),
      ),
    );
  }
}

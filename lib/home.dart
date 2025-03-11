import 'package:flutter/material.dart';
import 'perfil.dart';
import 'pedidos.dart';
import 'ayuda.dart';
import 'configuracion.dart';
import 'categorias.dart';
import 'reposteros.dart';
import 'menuLoginRegister.dart';


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
                if (result == true) {
                  setState(() {
                    _isLoggedIn = true;
                  });
                }
              },
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(color: Colors.white),
              ),
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

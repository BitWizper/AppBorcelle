import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importa la librería de Google Fonts
import 'perfil.dart';
import 'pedidos.dart';
import 'ayuda.dart';
import 'configuracion.dart';
import 'categorias.dart';
import 'reposteros.dart';
import 'menuLoginRegister.dart'; // Asegúrate de importar este archivo
import 'package:carousel_slider/carousel_slider.dart';

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
      '/menuLoginRegister': (context) => AuthScreen(),
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
  bool _isAuthenticated = false; // Variable de autenticación

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

    Navigator.pushNamed(context, route);
  }

  Future<void> cerrarSesion() async {
    setState(() {
      _isAuthenticated = false; // Cambiar estado al cerrar sesión
    });

    print("Sesión cerrada correctamente");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F), // Vino oscuro
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar pasteles...',
                  filled: true,
                  fillColor: Color(0xFFF2F0E4), // Beige claro
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
          if (!_isAuthenticated) // Muestra el botón solo si no está autenticado
            IconButton(
              icon: Icon(Icons.login),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/menuLoginRegister');
              },
              color: Color(0xFFF2F0E4), // Color claro (Beige claro) para los íconos
            ),
         PopupMenuButton<String>(
  onSelected: (value) {
    if (value == 'Cerrar Sesión') {
      _mostrarDialogoCerrarSesion(context);
    } else {
      print('Navegando a: $value');
      Navigator.pushReplacementNamed(context, value);
    }
  },
  itemBuilder: (BuildContext context) {
    return [
      PopupMenuItem(
        value: '/perfil',  // Ruta a la pantalla de perfil
        child: Text('Mi Perfil'),
      ),
      PopupMenuItem(
        value: '/pedidos', // Ruta a la pantalla de pedidos
        child: Text('Mis Pedidos'),
      ),
      PopupMenuItem(
        value: '/ayuda',  // Ruta a la pantalla de ayuda
        child: Text('Centro de Ayuda'),
      ),
      PopupMenuItem(
        value: '/configuracion', // Ruta a la pantalla de configuración
        child: Text('Configuración'),
      ),
      PopupMenuItem(
        value: 'Cerrar Sesión',  // Opción para cerrar sesión
        child: Text('Cerrar Sesión'),
      ),
    ];
  },
  icon: Icon(Icons.more_vert, color: Color(0xFFF2F0E4)), // Ícono claro para el menú
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildOfertasEspeciales(),
            SizedBox(height: 20),
            _buildDestacados(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Pasteles'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Reposteros'),
        ],
        selectedItemColor: Color(0xFFF2F0E4), // Íconos seleccionados en color claro (Beige claro)
        unselectedItemColor: Color(0xFF731D3C), // Borgoña para íconos no seleccionados
      ),
    );
  }

  Widget _buildOfertasEspeciales() {
    List<String> bannerImages = [
      "assets/fotodepasteles/banner1borcellitas.jpg",
      "assets/fotodepasteles/banner2borcellitas.jpg",
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ofertas Especiales",
            style: GoogleFonts.lora(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C1B2F),
            ), // Fuente Lora
          ),
          SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: 200, // Ajusta la altura según necesites
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              viewportFraction: 1, // Ocupa todo el ancho
            ),
            items: bannerImages.map((imagePath) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDestacados() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Destacados",
            style: GoogleFonts.lora(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C1B2F),
            ), // Fuente Lora
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              List<Map<String, String>> cakes = [
                {"image": "assets/fotodepasteles/fotopastel1.jpg", "name": "Pastel de Fresas", "price": "250 MXN"},
                {"image": "assets/fotodepasteles/fotopastel5.jpg", "name": "Pastel de Chocolate", "price": "220 MXN"},
                {"image": "assets/fotodepasteles/fotopastel3.jpg", "name": "Pastel Arcoíris", "price": "270 MXN"},
                {"image": "assets/fotodepasteles/fotopastel4.jpg", "name": "Pastel Red Velvet", "price": "300 MXN"},
              ];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Color(0xFF731D3C), width: 2), // Borgoña
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(cakes[index]["image"]!, fit: BoxFit.cover, width: double.infinity),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cakes[index]["name"]!,
                            style: GoogleFonts.lora(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8C1B2F),
                            ), // Fuente Lora
                          ),
                          Text(
                            cakes[index]["price"]!,
                            style: TextStyle(color: Color(0xFF731D3C)), // Borgoña
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cerrar Sesión', style: TextStyle(color: Color(0xFF8C1B2F))), // Vino oscuro
        content: Text('¿Estás seguro que deseas cerrar sesión?', style: TextStyle(color: Color(0xFF731D3C))), // Borgoña
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar', style: TextStyle(color: Color(0xFF731D3C)))), // Borgoña
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text('Aceptar', style: TextStyle(color: Color(0xFF8C1B2F))), // Vino oscuro
          ),
        ],
      ),
    );
  }
 }

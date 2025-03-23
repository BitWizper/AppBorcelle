import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'perfil.dart';
import 'pedidos.dart';
import 'ayuda.dart';
import 'configuracion.dart';
import 'package:borcelle/categorias.dart' as categorias;
import 'reposteros.dart';
import 'menuLoginRegister.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Model3D/MainMenuUI.dart';


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
  final bool _isAuthenticated = false;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _pasteles = [
    "Pastel de Fresas",
    "Pastel de Chocolate",
    "Pastel Arcoíris",
    "Pastel Red Velvet",
  ];
  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = _pasteles;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _pasteles
          .where((pastel) => pastel.toLowerCase().contains(query))
          .toList();

      if (_searchResults.isEmpty && query.isNotEmpty) {
        _searchResults = ["No encontrado"];
      }
    });
  }

  void cerrarSesion() async {
    final url = Uri.parse('TU_ENDPOINT/logout');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "token": "AQUI_EL_TOKEN_DEL_USUARIO"
        }),
      );

      if (response.statusCode == 200) {
        print("Sesión cerrada correctamente");
      } else {
        print("Error al cerrar sesión: ${response.body}");
      }
    } catch (e) {
      print("Error en la solicitud: $e");
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/categorias');
        break;
      case 2:
        Navigator.pushNamed(context, '/reposteros');
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Model3DViewer()),
        );
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar pasteles...',
                  filled: true,
                  fillColor: Color(0xFFF2F0E4),
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
          if (!_isAuthenticated)
            IconButton(
              icon: Icon(Icons.login),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/menuLoginRegister');
              },
              color: Color(0xFFF2F0E4),
            ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF8C1B2F),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF731D3C),
              ),
              child: Text(
                'Menú',
                style: GoogleFonts.lora(
                  color: Color(0xFFF2F0E4),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Color(0xFFF2F0E4)),
              title: Text(
                'Perfil',
                style: GoogleFonts.lora(
                  color: Color(0xFFF2F0E4),
                ),
              ),
              onTap: () {
                 Navigator.pushNamed(context, '/perfil');  // Redirige a la pantalla de perfil
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket, color: Color(0xFFF2F0E4)),
              title: Text(
                'Pedidos',
                style: GoogleFonts.lora(
                  color: Color(0xFFF2F0E4),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/pedidos');  // Redirige a la pantalla de pedid
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Color(0xFFF2F0E4)),
              title: Text(
                'Ayuda',
                style: GoogleFonts.lora(
                  color: Color(0xFFF2F0E4),
                ),
              ),
              onTap: () {
               Navigator.pushNamed(context, '/ayuda');  // Redirige a la pantalla de ayuda
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFFF2F0E4)),
              title: Text(
                'Configuración',
                style: GoogleFonts.lora(
                  color: Color(0xFFF2F0E4),
                ),
              ),
              onTap: () {
                 Navigator.pushNamed(context, '/configuracion');  // Redirige a la pantalla de configuración
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Color(0xFFF2F0E4)),
              title: Text(
                'Cerrar sesión',
                style: GoogleFonts.lora(
                  color: Color(0xFFF2F0E4),
                ),
              ),
              onTap: () {
                _mostrarDialogoCerrarSesion(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildOfertasEspeciales(),
            SizedBox(height: 20),
            _buildDestacados(),
            SizedBox(height: 20),
            ListView.builder(
              itemCount: _searchResults.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _searchResults[index],
                    style: TextStyle(
                      color: _searchResults[index] == "No encontrado" ? Colors.red : Colors.black,
                      fontWeight: _searchResults[index] == "No encontrado" ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: _searchResults[index] == "No encontrado" ? TextAlign.center : TextAlign.start,
                  ),
                );
              },
            ),
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
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'EditarPastel'),
        ],
        selectedItemColor: Color(0xFFF2F0E4),
        unselectedItemColor: Color(0xFF731D3C),
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
            ),
          ),
          SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              viewportFraction: 1,
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
            ),
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
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(cakes[index]["image"]!, fit: BoxFit.cover, height: 120, width: double.infinity),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(cakes[index]["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(cakes[index]["price"]!),
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cerrar sesión"),
          content: Text("¿Estás seguro de que deseas cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                cerrarSesion();
                Navigator.pushReplacementNamed(context, '/menuLoginRegister');
              },
              child: Text("Sí"),
            ),
          ],
        );
      },
    );
  }
}

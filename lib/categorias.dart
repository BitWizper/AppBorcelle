import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:borcelle/categorias.dart';
import 'package:borcelle/reposteros.dart';
import 'package:borcelle/menuLoginRegister.dart';
import 'package:borcelle/main.dart'; // Importamos HomeScreen
import 'package:borcelle/Model3D/MainMenuUI.dart'; // Importamos Model3DViewer
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  int _selectedIndex = 1; // Definir que estamos en Categorías

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
    _searchController.addListener(() {
  _onSearchChanged(_searchController.text);
    });

  }

  // Modificación del método onSearchChanged para recibir el texto directamente
  void _onSearchChanged(String query) {
    print("Buscando: $query"); // Esto debería mostrar el texto que estás buscando
    setState(() {
      query = query.toLowerCase();
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
                // Usamos un callback directamente aquí con el texto cambiado
                onChanged: _onSearchChanged,
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
                Navigator.pushNamed(context, '/perfil');
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
                Navigator.pushNamed(context, '/pedidos');
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
                Navigator.pushNamed(context, '/ayuda');
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
                Navigator.pushNamed(context, '/configuracion');
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
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Editar Pastel'),
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
            "Pasteles Destacados",
            style: GoogleFonts.lora(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C1B2F),
            ),
          ),
          SizedBox(height: 10),
          // Aquí puedes agregar más contenido
        ],
      ),
    );
  }

  // Mostrar un diálogo de confirmación para cerrar sesión
  void _mostrarDialogoCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cerrar sesión"),
          content: Text("¿Estás seguro de que deseas cerrar sesión?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Sí"),
              onPressed: () {
                cerrarSesion();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/menuLoginRegister');
              },
            ),
          ],
        );
      },
    );
  }
}

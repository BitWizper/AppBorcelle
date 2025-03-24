import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'perfil.dart';
import 'pedidos.dart';
import 'ayuda.dart';
import 'configuracion.dart';
import 'package:borcelle/categorias.dart';
import 'reposteros.dart';
import 'menuLoginRegister.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'package:borcelle/Model3D/MainMenuUI.dart';
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
      '/crearPastel': (context) => Model3DViewer(),

    },
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> consejos = [
    "Usa ingredientes frescos para un mejor sabor.",
    "Precalienta tu horno antes de hornear.",
    "Deja que los pasteles se enfríen antes de decorarlos.",
    "Usa una espátula caliente para un glaseado perfecto."
  ];
  String consejoActual = "";
  late Timer _consejoTimer;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    consejoActual = consejos[0];
    _consejoTimer = Timer.periodic(Duration(minutes: 2), (timer) {
      setState(() {
        consejoActual = (consejos..shuffle()).first;
      });
    });
  }

  @override
  void dispose() {
    _consejoTimer.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        automaticallyImplyLeading: false, // Oculta el botón de volver
        title: Text(
          "Borcelle",
          style: GoogleFonts.lora(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: SearchDelegateExample());
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/pedidos');
            },
          ),
          IconButton(
  icon: Icon(isLoggedIn ? Icons.exit_to_app : Icons.login, color: Colors.white),
  onPressed: () {
    if (isLoggedIn) {
      _showLogoutDialog(context);
    } else {
      Navigator.pushNamed(context, '/menuLoginRegister').then((value) {
        // Cuando vuelva desde el login, verificar si se autenticó
        setState(() {
          isLoggedIn = value == true; // Solo cambia si el login fue exitoso
        });
      });
    }
  },
),
          PopupMenuButton<String>(
  icon: Icon(Icons.menu, color: Colors.white),
  onSelected: (value) {
    switch (value) {
      case 'categorias':  // Asegúrate de que el valor coincida con el PopupMenuItem
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'reposteros':
        Navigator.pushNamed(context, '/reposteros');
        break;
      case 'crearpastel':
        Navigator.pushNamed(context, '/crearPastel');
        break;
      case 'perfil':
        Navigator.pushNamed(context, '/perfil');
        break;
      case 'ayuda':
        Navigator.pushNamed(context, '/ayuda');
        break;
      case 'configuracion':
        Navigator.pushNamed(context, '/configuracion');
        break;
    }
  },
  itemBuilder: (context) => [
    PopupMenuItem(value: 'categorias', child: Text('Pasteles')), // Cambia el texto a "Pasteles"
    PopupMenuItem(value: 'reposteros', child: Text('Reposteros')),
    PopupMenuItem(value: 'crearpastel', child: Text('Crear Pastel')),
    PopupMenuItem(value: 'perfil', child: Text('Perfil')),
    PopupMenuItem(value: 'ayuda', child: Text('Ayuda')),
    PopupMenuItem(value: 'configuracion', child: Text('Configuración')),
  ],
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
            SizedBox(height: 20),
            _buildConsejos(),
            SizedBox(height: 20),
            _buildFeedRedes(),
          ],
        ),
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
            style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8C1B2F)),
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
            style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8C1B2F)),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(cakes[index]["image"]!, fit: BoxFit.cover, height: 120, width: double.infinity),
                    ),
                    Padding(padding: EdgeInsets.all(8), child: Text(cakes[index]["name"]!, style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(cakes[index]["price"]!)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConsejos() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.circular(10)),
      child: Text("💡 Consejo: $consejoActual", style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8C1B2F))),
    );
  }

  Widget _buildFeedRedes() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("📢 Últimas noticias de redes", style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8C1B2F))),
          SizedBox(height: 10),
          Text("📸 Instagram: ¡Nuevo diseño de pastel disponible! 🎂"),
          Text("🕺🎵tik tok: Sorpresas este fin de semana, siguenos como Borcelle. 🎉"),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Cerrar sesión"),
        content: Text("¿Estás seguro de que deseas cerrar sesión?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancelar
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isLoggedIn = false;
              });
              Navigator.pop(context); // Cierra el diálogo
              Navigator.pushReplacementNamed(context, '/menuLoginRegister'); // Redirige al login
              },
             child: Text("Cerrar sesión"),
            ),
          ],
        );
      },
    );
  }

 }

 class SearchDelegateExample extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Resultados de búsqueda para "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      "Pastel de Fresas",
      "Pastel de Chocolate",
      "Pastel Arcoíris",
      "Pastel Red Velvet"
    ];

    final result = query.isEmpty
        ? suggestions
        : suggestions.where((s) => s.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(result[index]),
          onTap: () {
            query = result[index];
            showResults(context);
          },
        );
      },
    );
  }
}

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
  final TextEditingController _searchController = TextEditingController(); // Controlador para el campo de búsqueda
  final List<String> _pasteles = [
    "Pastel de Fresas",
    "Pastel de Chocolate",
    "Pastel Arcoíris",
    "Pastel Red Velvet",
  ]; // Lista de ejemplo de pasteles
  List<String> _searchResults = []; // Lista para almacenar los resultados de la búsqueda

  @override
  void initState() {
    super.initState();
    _searchResults = _pasteles; // Inicialmente muestra todos los pasteles
    _searchController.addListener(_onSearchChanged); // Escucha los cambios en el campo de búsqueda
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


  @override
  void dispose() {
    _searchController.dispose(); // Libera el controlador al salir de la pantalla
    super.dispose();
  }

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
                controller: _searchController, // Asocia el controlador con el campo de texto
                decoration: InputDecoration(
                  hintText: 'Buscar pasteles...', // Texto que aparece cuando no se ha ingresado nada
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
            SizedBox(height: 20),
            // Aquí se muestra el resultado de búsqueda
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
              onPressed: () {
                cerrarSesion();
                Navigator.pop(context);
              },
              child: Text("Cerrar sesión"),
            ),
          ],
        );
      },
    );
  }
}

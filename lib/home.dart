import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'perfil.dart';
import 'pedidos.dart';
import 'ayuda.dart';
import 'configuracion.dart';
import 'package:borcelle/categorias.dart';
import 'reposteros.dart';
import 'menuLoginRegister.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'dart:async';
import 'package:borcelle/Model3D/MainMenuUI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      '/configuracion': (context) => ConfiguracionScreen(),
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
  bool _isLoading = true;
  bool _isLoggedIn = false;
  List<Map<String, dynamic>> _pasteles = [];
  final List<String> _consejos = [
    "¡Hoy es un día perfecto para probar nuestros deliciosos pasteles!",
    "¿Sabías que nuestros pasteles son horneados diariamente?",
    "¡No olvides que puedes personalizar tus pasteles!",
    "¡Visita nuestra sección de ofertas especiales!",
    "¡Los pasteles son la mejor manera de celebrar!",
    "¡Prueba nuestros pasteles sin azúcar!",
    "¡Haz tu pedido con anticipación para eventos especiales!",
    "¡Sigue nuestras redes sociales para más consejos!",
    "¡Los pasteles son el regalo perfecto!",
    "¡Descubre nuestras nuevas creaciones!"
  ];
  int _consejoActual = 0;
  Timer? _timer;
  List<Map<String, dynamic>> _pasteleros = [];
  List<Map<String, dynamic>> _categorias = [];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _loadPasteles();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          _consejoActual = (_consejoActual + 1) % _consejos.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              showSearch(context: context, delegate: CustomSearchDelegate(pasteles: _pasteles));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              if (!_isLoggedIn) {
                _showLoginRequiredDialog(context, 'carrito de compras');
              } else {
                Navigator.pushNamed(context, '/pedidos');
              }
            },
          ),
          IconButton(
            icon: Icon(_isLoggedIn ? Icons.exit_to_app : Icons.login, color: Colors.white),
            onPressed: () {
              if (_isLoggedIn) {
                _showLogoutDialog(context);
              } else {
                _showLoginRequiredDialog(context, 'iniciar sesión');
              }
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.white),
            onSelected: (value) async {
              if (!_isLoggedIn) {
                // Mostrar diálogo de inicio de sesión requerido
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Inicio de sesión requerido",
                        style: TextStyle(color: Color(0xFF8C1B2F)),
                      ),
                      content: Text("Debes iniciar sesión para acceder a esta función."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Cerrar diálogo
                          },
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Cerrar diálogo
                            Navigator.pushNamed(context, '/menuLoginRegister').then((value) {
                              if (value == true) {
                                setState(() {
                                  _isLoggedIn = true;
                                });
                                // Navegar a la opción seleccionada después de iniciar sesión
                                _navigateToSelectedOption(value.toString());
                              }
                            });
                          },
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: Color(0xFF8C1B2F)),
                          ),
                        ),
                      ],
                    );
                  },
                );
                return;
              }
              // Si está logueado, navegar normalmente
              _navigateToSelectedOption(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'categorias', child: Text('Pasteles')),
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
            _buildConsejoDelDia(),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ofertas Especiales",
            style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF8C1B2F)),
          ),
          const SizedBox(height: 10),
          FlutterCarousel(
            items: bannerImages.map((imagePath) {
              return GestureDetector(
                onTap: () {
                  if (!_isLoggedIn) {
                    _showLoginRequiredDialog(context, 'ver ofertas especiales');
                  } else {
                    Navigator.pushNamed(context, '/categorias');
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFA65168).withOpacity(0.3), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              viewportFraction: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestacados() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Destacados",
            style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8C1B2F)),
          ),
          const SizedBox(height: 10),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: _pasteles.length > 4 ? 4 : _pasteles.length,
                  itemBuilder: (context, index) {
                    return _buildPastelCard(_pasteles[index]);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildPastelCard(Map<String, dynamic> pastel) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: const Color(0xFFA65168).withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFA65168).withOpacity(0.3), width: 1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Image.asset(
                pastel["image"],
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error cargando imagen: $error');
                  return Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/fotodepasteles/iconoborcelle.jpg',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Cargando...',
                            style: TextStyle(
                              color: Color(0xFF8C1B2F),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  pastel["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8C1B2F),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  pastel["price"],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFA65168),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsejoDelDia() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFF8C1B2F), size: 24),
              SizedBox(width: 8),
              Text(
                "Consejo del Día",
                style: GoogleFonts.lora(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1B2F),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            _consejos[_consejoActual],
            style: GoogleFonts.lora(
              fontSize: 16,
              color: Color(0xFFA65168),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedRedes() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Síguenos en Redes Sociales",
            style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8C1B2F)),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialButton(Icons.facebook, "Facebook"),
              _buildSocialButton(Icons.camera_alt, "Instagram"),
              _buildSocialButton(Icons.bookmark, "Pinterest"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFFA65168), size: 30),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFA65168),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita que se cierre al tocar fuera
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Cerrar sesión",
            style: TextStyle(color: Color(0xFF8C1B2F)),
          ),
          content: Text("¿Estás seguro de que deseas cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Actualizar el estado
                setState(() {
                  _isLoggedIn = false;
                });
                
                // Limpiar las preferencias de sesión
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                
                // Cerrar el diálogo
                Navigator.pop(context);
                
                // Redirigir al login y limpiar el stack de navegación
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/menuLoginRegister',
                  (route) => false,
                );
              },
              child: Text(
                "Aceptar",
                style: TextStyle(color: Color(0xFF8C1B2F)),
              ),
            ),
          ],
        );
      },
    );
  }

  // Agregar esta nueva función para manejar la navegación
  void _navigateToSelectedOption(String value) {
    switch (value) {
      case 'categorias':
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
  }

  // Agregar esta nueva función para mostrar el diálogo de login requerido
  void _showLoginRequiredDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Inicio de sesión requerido",
            style: TextStyle(color: Color(0xFF8C1B2F)),
          ),
          content: Text("Debes iniciar sesión para acceder a la función de $feature."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar diálogo
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Cerrar diálogo
                final result = await Navigator.pushNamed(context, '/menuLoginRegister');
                if (result == true) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', true);
                  setState(() {
                    _isLoggedIn = true;
                  });
                  // Si el usuario inició sesión exitosamente, realizar la acción original
                  if (feature == 'carrito de compras') {
                    Navigator.pushNamed(context, '/pedidos');
                  }
                }
              },
              child: Text(
                "Iniciar Sesión",
                style: TextStyle(color: Color(0xFF8C1B2F)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadPasteles() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Datos temporales mientras se desarrolla el backend
      final List<Map<String, dynamic>> pastelesTemporales = [
        {
          "name": "Pastel de Chocolate Premium",
          "price": "\$450",
          "image": "assets/fotodepasteles/pastelprimero.jpg",
          "description": "Delicioso pastel de chocolate con decoración elegante"
        },
        {
          "name": "Pastel de Fresa Silvestre",
          "price": "\$380",
          "image": "assets/fotodepasteles/fotopastel1.jpg",
          "description": "Fresco pastel de fresa con decoración moderna"
        },
        {
          "name": "Pastel de Vainilla Francesa",
          "price": "\$350",
          "image": "assets/fotodepasteles/fotopastel2.jpeg",
          "description": "Clásico pastel de vainilla con decoración tradicional"
        },
        {
          "name": "Pastel de Almendra Gourmet",
          "price": "\$420",
          "image": "assets/fotodepasteles/pasteldealmendra.jpg",
          "description": "Exquisito pastel de almendra con decoración elegante"
        },
        {
          "name": "Pastel de Queso New York",
          "price": "\$400",
          "image": "assets/fotodepasteles/pasteldequesodebola.jpg",
          "description": "Cremoso pastel de queso con decoración moderna"
        },
        {
          "name": "Pastel de Mandarina Refrescante",
          "price": "\$360",
          "image": "assets/fotodepasteles/pasteldemandarina.png",
          "description": "Refrescante pastel de mandarina con decoración elegante"
        }
      ];

      // Simular delay de red
      await Future.delayed(const Duration(seconds: 1));
      
      if (!mounted) return;
      
      setState(() {
        _pasteles = pastelesTemporales;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error al cargar los pasteles: $e');
    }
  }

  Future<void> _checkLoginStatus() async {
    if (!mounted) return;
    
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> pasteles;

  CustomSearchDelegate({required this.pasteles});

  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> resultados = pasteles
        .where((pastel) => pastel["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  resultados[index]["image"],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error cargando imagen en búsqueda: $error');
                    return Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/fotodepasteles/iconoborcelle.jpg',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Cargando...',
                              style: TextStyle(
                                color: Color(0xFF8C1B2F),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      resultados[index]["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      resultados[index]["price"]!,
                      style: TextStyle(color: Color(0xFF8C1B2F)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Busca tu pastel favorito",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    List<Map<String, dynamic>> sugerencias = pasteles
        .where((pastel) => pastel["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: sugerencias.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: ClipOval(
              child: Image.asset(
                sugerencias[index]["image"],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error cargando imagen en sugerencia: $error');
                  return Image.asset(
                    'assets/fotodepasteles/iconoborcelle.jpg',
                    width: 24,
                    height: 24,
                  );
                },
              ),
            ),
          ),
          title: Text(sugerencias[index]["name"]!),
          subtitle: Text(sugerencias[index]["price"]!),
          onTap: () {
            query = sugerencias[index]["name"]!;
            showResults(context);
          },
        );
      },
    );
  }
}
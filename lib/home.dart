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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  bool isLoading = true;
  bool isLoggedIn = false;
  List<Map<String, dynamic>> pasteles = [];
  List<String> consejos = [
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
  int consejoActual = 0;
  Timer? _timer;
  List<Map<String, dynamic>> pasteleros = [];
  List<Map<String, dynamic>> categorias = [];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _loadPasteles();
    // Iniciar el timer para cambiar el consejo cada minuto
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        consejoActual = (consejoActual + 1) % consejos.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el timer cuando se destruye el widget
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
              showSearch(context: context, delegate: CustomSearchDelegate(pasteles: pasteles));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              if (!isLoggedIn) {
                _showLoginRequiredDialog(context, 'carrito de compras');
              } else {
                Navigator.pushNamed(context, '/pedidos');
              }
            },
          ),
          IconButton(
            icon: Icon(isLoggedIn ? Icons.exit_to_app : Icons.login, color: Colors.white),
            onPressed: () {
              if (isLoggedIn) {
                _showLogoutDialog(context);
              } else {
                _showLoginRequiredDialog(context, 'iniciar sesión');
              }
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.white),
            onSelected: (value) async {
              if (!isLoggedIn) {
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
                                  isLoggedIn = true;
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
              return GestureDetector(
                onTap: () {
                  if (!isLoggedIn) {
                    _showLoginRequiredDialog(context, 'ver ofertas especiales');
                  } else {
                    Navigator.pushNamed(context, '/categorias');
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
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
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: pasteles.length > 4 ? 4 : pasteles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (!isLoggedIn) {
                            _showLoginRequiredDialog(context, 'ver detalles del pastel');
                          } else {
                            Navigator.pushNamed(context, '/categorias');
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: pasteles[index]["image"],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8C1B2F)),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) {
                                      print('Error cargando imagen: $error');
                                      return Container(
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: Icon(
                                            Icons.cake,
                                            size: 40,
                                            color: Color(0xFF8C1B2F),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pasteles[index]["name"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8C1B2F),
                                    ),
                                  ),
                                  Text(
                                    pasteles[index]["price"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFA65168),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
            consejos[consejoActual],
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
                  isLoggedIn = false;
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
                    isLoggedIn = true;
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
    setState(() {
      isLoading = true;
    });

    try {
      // Simulación de carga de datos
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        pasteles = [
          {
            "name": "Pastel de Chocolate",
            "price": "\$450",
            "image": "https://i.pinimg.com/736x/8d/4d/20/8d4d20b75a8d8b13e3d2907c5c58e633.jpg",
            "description": "Delicioso pastel de chocolate con decoración elegante"
          },
          {
            "name": "Pastel de Fresa",
            "price": "\$380",
            "image": "https://i.pinimg.com/736x/f2/27/f7/f227f7e5778e8f43e95624fffb1f181a.jpg",
            "description": "Fresco pastel de fresa con decoración moderna"
          },
          {
            "name": "Pastel de Vainilla",
            "price": "\$350",
            "image": "https://i.pinimg.com/736x/90/22/37/902237e139c0a842bb30c1f440547c51.jpg",
            "description": "Clásico pastel de vainilla con decoración tradicional"
          },
          {
            "name": "Pastel de Almendra",
            "price": "\$420",
            "image": "https://i.pinimg.com/736x/8c/5b/1a/8c5b1a748e005348668423ffcb5a84c8.jpg",
            "description": "Exquisito pastel de almendra con decoración elegante"
          },
          {
            "name": "Pastel de Queso",
            "price": "\$400",
            "image": "https://i.pinimg.com/736x/42/76/61/427661b16c109e9c10770ea33a58c09b.jpg",
            "description": "Cremoso pastel de queso con decoración moderna"
          },
          {
            "name": "Pastel de Mandarina",
            "price": "\$360",
            "image": "https://i.pinimg.com/736x/99/e3/51/99e3515f3f5a4acfa13e352717626dcb.jpg",
            "description": "Refrescante pastel de mandarina con decoración elegante"
          }
        ];
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar los pasteles: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
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
        childAspectRatio: 0.8,
      ),
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: resultados[index]["image"],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) {
                    print('Error cargando imagen en búsqueda: $error');
                    return Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.cake, size: 50, color: Color(0xFF8C1B2F)),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              child: CachedNetworkImage(
                imageUrl: sugerencias[index]["image"],
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) {
                  print('Error cargando imagen en sugerencia: $error');
                  return Icon(Icons.cake, size: 24, color: Color(0xFF8C1B2F));
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
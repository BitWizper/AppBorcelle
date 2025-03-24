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
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  List<String> consejos = [
    "Usa ingredientes frescos para un mejor sabor.",
    "Precalienta tu horno antes de hornear.",
    "Deja que los pasteles se enfríen antes de decorarlos.",
    "Usa una espátula caliente para un glaseado perfecto."
  ];
  String consejoActual = "";
  late Timer _consejoTimer;
  bool isLoggedIn = false;
  List<Map<String, dynamic>> pasteles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    consejoActual = consejos[0];
    _consejoTimer = Timer.periodic(Duration(minutes: 2), (timer) {
      setState(() {
        consejoActual = (consejos..shuffle()).first;
      });
    });
    _checkLoginStatus();
    _cargarPasteles();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  Future<void> _cargarPasteles() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/pastel/obtenerpasteles'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Datos recibidos del backend: $data'); // Para debug

        setState(() {
          pasteles = data.where((pastel) => 
            (pastel['popularidad'] ?? 0) > 4 && (pastel['destacado'] ?? false)
          ).map((pastel) => {
            'name': pastel['nombre'] ?? '',
            'price': '${pastel['precio'] ?? 0} MXN',
            'image': pastel['imagen_url'] ?? '',
            'descripcion': pastel['descripcion'] ?? '',
            'popularidad': pastel['popularidad'] ?? 0,
            'id_pastel': pastel['id_pastel'],
            'id_repostero': pastel['id_repostero'],
            'id_categoria': pastel['id_categoria'],
            'destacado': pastel['destacado'] ?? false,
          }).toList();
          isLoading = false;
        });

        print('URLs de imágenes cargadas:');
        for (var pastel in pasteles) {
          print('Imagen URL: ${pastel['image']}');
        }
        print('Pasteles destacados cargados: ${pasteles.length}');
      } else {
        print('Error al cargar los pasteles: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error al cargar los pasteles: $e');
      setState(() {
        isLoading = false;
      });
    }
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
              return GestureDetector(
                onTap: () {
                  if (!isLoggedIn) {
                    _showLoginRequiredDialog(context, 'ver ofertas especiales');
                  } else {
                    // Aquí iría la navegación a las ofertas cuando esté logueado
                    Navigator.pushNamed(context, '/categorias');
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                height: 120,
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: pasteles[index]["image"],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) {
                                    print('Error cargando imagen: $error');
                                    print('URL que falló: $url');
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(Icons.cake, size: 50, color: Color(0xFF8C1B2F)),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                pasteles[index]["name"]!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                pasteles[index]["price"]!,
                                style: TextStyle(color: Color(0xFF8C1B2F)),
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
              onPressed: () {
                Navigator.pop(context); // Cerrar diálogo
                Navigator.pushNamed(context, '/menuLoginRegister').then((value) {
                  if (value == true) {
                    setState(() {
                      isLoggedIn = true;
                    });
                    // Si el usuario inició sesión exitosamente, realizar la acción original
                    if (feature == 'carrito de compras') {
                      Navigator.pushNamed(context, '/pedidos');
                    }
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
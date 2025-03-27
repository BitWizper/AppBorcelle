import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reposteros',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Poppins',
      ),
      home: const ReposterosScreen(),
    );
  }
}

class ReposterosScreen extends StatelessWidget {
  const ReposterosScreen({super.key});

  final Map<String, List<Map<String, dynamic>>> categorias = const {
    'XV Años': [
      {
        'nombre': 'Ana Martínez',
        'imagen': 'assets/fotodepasteles/iconoborcelle.jpg',
        'calificacion': 4.9,
        'reseñas': 'Excelente servicio'
      },
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
    ],
    'Bautizos': [
      {'nombre': 'Laura Hernández', 'imagen': 'assets/repostera3.jpg', 'calificacion': 4.8, 'reseñas': 'Súper recomendado'},
      {'nombre': 'Fernando Díaz', 'imagen': 'assets/repostero4.jpg', 'calificacion': 4.6, 'reseñas': 'Gran presentación'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
    ],
    'Baby shower': [
      {'nombre': 'Laura Hernández', 'imagen': 'assets/repostera3.jpg', 'calificacion': 4.8, 'reseñas': 'Súper recomendado'},
      {'nombre': 'Fernando Díaz', 'imagen': 'assets/repostero4.jpg', 'calificacion': 4.6, 'reseñas': 'Gran presentación'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
    ],
    'cumpleaños': [
      {'nombre': 'Laura Hernández', 'imagen': 'assets/repostera3.jpg', 'calificacion': 4.8, 'reseñas': 'Súper recomendado'},
      {'nombre': 'Fernando Díaz', 'imagen': 'assets/repostero4.jpg', 'calificacion': 4.6, 'reseñas': 'Gran presentación'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
    ],
    'bodas': [
      {'nombre': 'Laura Hernández', 'imagen': 'assets/repostera3.jpg', 'calificacion': 4.8, 'reseñas': 'Súper recomendado'},
      {'nombre': 'Fernando Díaz', 'imagen': 'assets/repostero4.jpg', 'calificacion': 4.6, 'reseñas': 'Gran presentación'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
      {'nombre': 'Carlos Gómez', 'imagen': 'assets/repostero2.jpg', 'calificacion': 4.7, 'reseñas': 'Deliciosos pasteles'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reposteros', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF8C1B2F),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          String categoria = categorias.keys.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoria,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1B2F),
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categorias[categoria]!.length,
                itemBuilder: (context, reposteroIndex) {
                  var repostero = categorias[categoria]![reposteroIndex];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: const Color(0xFFA65168).withOpacity(0.3), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFA65168).withOpacity(0.3), width: 1),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: repostero['imagen'],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/fotodepasteles/iconoborcelle.jpg',
                                          width: 40,
                                          height: 40,
                                        ),
                                        const SizedBox(height: 8),
                                        const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8C1B2F)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  debugPrint('Error cargando imagen: $error');
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                repostero['nombre'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8C1B2F),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    repostero['calificacion'].toString(),
                                    style: const TextStyle(
                                      color: Color(0xFFA65168),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                repostero['reseñas'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFA65168),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }
}

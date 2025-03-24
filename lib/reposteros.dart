import 'package:flutter/material.dart';

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
      {'nombre': 'Ana Martínez', 'imagen': 'assets/repostera1.jpg', 'calificacion': 4.9, 'reseñas': 'Excelente servicio'},
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
        title: Text('Reposteros', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF8C1B2F),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          String categoria = categorias.keys.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoria,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1B2F),
                ),
              ),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      side: BorderSide(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: Image.asset(
                              repostero['imagen'],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                repostero['nombre'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8C1B2F),
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    repostero['calificacion'].toString(),
                                    style: TextStyle(
                                      color: Color(0xFFA65168),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                repostero['reseñas'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFA65168),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }
}

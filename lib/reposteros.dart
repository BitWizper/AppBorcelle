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
        title: const Text('Catálogo de Reposteros'),
        backgroundColor: Color(0xFF8C1B2F),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categorias.entries.map((categoria) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoria.key,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF731D3C),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoria.value.length,
                      itemBuilder: (context, index) {
                        var repostero = categoria.value[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F0E4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFFA65168), width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                  child: Image.asset(
                                    repostero['imagen'],
                                    width: 140,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        repostero['nombre'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF731D3C),
                                        ),
                                      ),
                                      Text(
                                        '${repostero['calificacion']} ★',
                                        style: TextStyle(color: Colors.orange[700]),
                                      ),
                                      Text(
                                        repostero['reseñas'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 12, color: Colors.black87),
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
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

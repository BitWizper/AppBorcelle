import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:borcelle/services/favoritos_service.dart';

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
                  return _buildReposteroCard(repostero);
                },
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReposteroCard(Map<String, dynamic> repostero) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(repostero['imagen']),
        ),
        title: Text(repostero['nombre']),
        subtitle: Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            SizedBox(width: 4),
            Text('${repostero['calificacion']}'),
            SizedBox(width: 8),
            Text('(${repostero['reseñas']} reseñas)'),
          ],
        ),
        trailing: Consumer<FavoritosService>(
          builder: (context, favoritosService, child) {
            final esFavorito = favoritosService.esReposteroFavorito(repostero['id']);
            return IconButton(
              icon: Icon(
                esFavorito ? Icons.favorite : Icons.favorite_border,
                color: esFavorito ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                if (esFavorito) {
                  favoritosService.quitarReposteroFavorito(repostero['id']);
                } else {
                  favoritosService.agregarReposteroFavorito(repostero);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

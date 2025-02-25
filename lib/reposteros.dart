import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reposteros',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Poppins',
      ),
      home: CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  final List<Map<String, dynamic>> reposteros = [
    {
      'nombre': 'Ana Martínez',
      'imagen': 'assets/repostera1.jpg',
      'descripcion': 'Especialista en pasteles fondant.',
      'estrellas': 5,
      'reseñas': ['Excelentes pasteles!', 'Muy recomendable.'],
      'puntaje': 4.9,
    },
    {
      'nombre': 'Mario Pérez',
      'imagen': 'assets/repostero3.jpg',
      'descripcion': 'Experto en repostería francesa.',
      'estrellas': 4,
      'reseñas': ['Deliciosos croissants!'],
      'puntaje': 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reposteros'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: reposteros.length,
          itemBuilder: (context, index) {
            final repostero = reposteros[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      repostero['imagen'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          repostero['nombre'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          repostero['descripcion'],
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < repostero['estrellas']
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.orange,
                              size: 20,
                            );
                          }),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Puntaje: ${repostero['puntaje']}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _showProfilePopup(context, index),
                          child: Text('Ver Perfil'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.pink,
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
      ),
    );
  }

  void _showProfilePopup(BuildContext context, int index) {
    final repostero = reposteros[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(repostero['nombre']),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(repostero['descripcion']),
                SizedBox(height: 10),
                Row(
                  children: List.generate(5, (starIndex) {
                    return Icon(
                      starIndex < repostero['estrellas']
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.orange,
                    );
                  }),
                ),
                SizedBox(height: 10),
                Text('Puntaje: ${repostero['puntaje']}'),
                SizedBox(height: 10),
                Text('Reseñas:'),
                // Aquí está la corrección:
                ...repostero['reseñas'].map<Widget>((resena) => Text('- $resena')).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

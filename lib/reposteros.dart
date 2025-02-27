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

class ReposterosScreen extends StatefulWidget {
  const ReposterosScreen({super.key});

  @override
  _ReposterosScreenState createState() => _ReposterosScreenState();
}

class _ReposterosScreenState extends State<ReposterosScreen> {
  final List<Map<String, dynamic>> reposteros = [
    {
      'nombre': 'Ana Martínez',
      'imagen': 'assets/repostera1.jpg',
      'descripcion': 'Especialista en pasteles fondant.',
      'estrellas': 5,
      'reseñas': ['¡Excelentes pasteles!', '¡Muy recomendable!'],
      'puntaje': 4.9,
    },
    {
      'nombre': 'Mario Pérez',
      'imagen': 'assets/repostero3.jpg',
      'descripcion': 'Experto en repostería francesa.',
      'estrellas': 4,
      'reseñas': ['¡Deliciosos croissants!'],
      'puntaje': 4.5,
    },
  ];

  List<Map<String, dynamic>> _filteredReposteros = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredReposteros = reposteros;
  }

  void _filterReposteros(String query) {
    final filtered = reposteros.where((repostero) {
      final nombreLower = repostero['nombre'].toLowerCase();
      final descripcionLower = repostero['descripcion'].toLowerCase();
      final queryLower = query.toLowerCase();

      return nombreLower.contains(queryLower) || descripcionLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredReposteros = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reposteros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final searchQuery = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(onQueryChanged: _filterReposteros),
              );
              if (searchQuery != null) {
                _filterReposteros(searchQuery);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _filteredReposteros.length,
          itemBuilder: (context, index) {
            final repostero = _filteredReposteros[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          repostero['descripcion'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 5),
                        Text(
                          'Puntaje: ${repostero['puntaje']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _showProfilePopup(context, index),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.pink,
                          ),
                          child: const Text('Ver Perfil'),
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
    final repostero = _filteredReposteros[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(repostero['nombre']),
          content: Text(repostero['descripcion']),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String?> {
  final Function(String) onQueryChanged;

  CustomSearchDelegate({required this.onQueryChanged});

  @override
  String? get searchFieldLabel => 'Buscar reposteros...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onQueryChanged('');
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(child: Text('Resultados de la búsqueda'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChanged(query);
    return Container();
  }
}

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
  int _selectedIndex = 2; // El índice de la pantalla seleccionada
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> reposteros = [
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

  @override
  void initState() {
    super.initState();
    _filteredReposteros = reposteros;
  }

  void _onSearchChanged() {
    setState(() {
      _filteredReposteros = reposteros
          .where((repostero) => repostero['nombre']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onFooterTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/categorias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reposteros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _onSearchChanged();
              },
              decoration: const InputDecoration(
                labelText: 'Buscar repostero',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredReposteros.length,
              itemBuilder: (context, index) {
                var repostero = _filteredReposteros[index];
                return ListTile(
                  leading: Image.asset(repostero['imagen']),
                  title: Text(repostero['nombre']),
                  subtitle: Text(repostero['descripcion']),
                  trailing: Text(repostero['puntaje'].toString()),
                  onTap: () {
                    // Aquí puedes agregar la acción al hacer clic en el repostero.
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onFooterTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Categorías',
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> reposteros = [
    {
      'nombre': 'Ana Martínez',
      'imagen': 'assets/repostera1.jpg',
      'descripcion': 'Especialista en pasteles fondant.',
    },
    {
      'nombre': 'Mario Pérez',
      'imagen': 'assets/repostero3.jpg',
      'descripcion': 'Experto en repostería francesa.',
    },
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: reposteros
          .where((repostero) => repostero['nombre']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList()
          .length,
      itemBuilder: (context, index) {
        var repostero = reposteros[index];
        return ListTile(
          leading: Image.asset(repostero['imagen']),
          title: Text(repostero['nombre']),
          subtitle: Text(repostero['descripcion']),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = reposteros
        .where((repostero) => repostero['nombre']
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        var repostero = suggestions[index];
        return ListTile(
          leading: Image.asset(repostero['imagen']),
          title: Text(repostero['nombre']),
          subtitle: Text(repostero['descripcion']),
        );
      },
    );
  }
}

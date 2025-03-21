import 'package:flutter/material.dart';



class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  final List<Map<String, dynamic>> categorias = [
    {
      'nombre': 'Bodas',
      'imagen': 'assets/bodas.jpg',
      'descripcion': 'Pasteles elegantes para bodas.',
    },
    {
      'nombre': 'XV Años',
      'imagen': 'assets/xv.jpg',
      'descripcion': 'Pasteles coloridos para XV años.',
    },
    {
      'nombre': 'Cumpleaños',
      'imagen': 'assets/cumple.jpg',
      'descripcion': 'Diversión y sabor en cada bocado.',
    },
  ];

  List<Map<String, dynamic>> _filteredCategorias = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredCategorias = categorias;
  }

  void _filterCategorias(String query) {
    final filtered = categorias.where((categoria) {
      final nombreLower = categoria['nombre'].toLowerCase();
      final descripcionLower = categoria['descripcion'].toLowerCase();
      final queryLower = query.toLowerCase();
      return nombreLower.contains(queryLower) || descripcionLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredCategorias = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C1B2F),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: _filterCategorias,
                decoration: InputDecoration(
                  hintText: 'Buscar categorías...',
                  filled: true,
                  fillColor: const Color(0xFFF2F0E4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _filteredCategorias.length,
          itemBuilder: (context, index) {
            final categoria = _filteredCategorias[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      categoria['imagen'],
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
                          categoria['nombre'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categoria['descripcion'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _showCategoriaDetalles(context, categoria['nombre']),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.pink,
                          ),
                          child: const Text('Ver Pasteles'),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Pasteles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: const Color(0xFFF2F0E4),
        unselectedItemColor: const Color(0xFF731D3C),
        onTap: _onItemTapped,
      ),
    );
  }

  void _showCategoriaDetalles(BuildContext context, String categoria) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriaDetalleScreen(categoria: categoria),
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home'); // Navegar a HomeScreen
        break;
      case 1:
        Navigator.pushNamed(context, '/pasteles'); // Navegar a PastelesScreen (Si tienes esa pantalla)
        break;
      case 2:
        // Aquí ya estás en Categorías, no necesitas hacer nada.
        break;
      default:
        break;
    }
  }
}

class CategoriaDetalleScreen extends StatelessWidget {
  final String categoria;
  final List<Map<String, dynamic>> pasteles = [
    {'nombre': 'Pastel de Boda Clásico', 'categoria': 'Bodas', 'imagen': 'assets/boda1.jpg'},
    {'nombre': 'Pastel XV Rosa', 'categoria': 'XV Años', 'imagen': 'assets/xv1.jpg'},
    {'nombre': 'Pastel Cumpleaños Arcoiris', 'categoria': 'Cumpleaños', 'imagen': 'assets/cumple1.jpg'},
  ];

  CategoriaDetalleScreen({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    final pastelesFiltrados = pasteles.where((p) => p['categoria'] == categoria).toList();
    return Scaffold(
      appBar: AppBar(title: Text('Pasteles de $categoria')),
      body: pastelesFiltrados.isEmpty
          ? const Center(child: Text('No hay pasteles disponibles.'))
          : ListView.builder(
              itemCount: pastelesFiltrados.length,
              itemBuilder: (context, index) {
                final pastel = pastelesFiltrados[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset(pastel['imagen'], height: 200, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          pastel['nombre'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

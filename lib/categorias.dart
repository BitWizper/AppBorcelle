import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final int _selectedIndex = 1; // "Categorías"

  @override
  void initState() {
    super.initState();
    _filteredCategorias = categorias;
  }

  void _filterCategorias(String query) {
    setState(() {
      _filteredCategorias = categorias.where((categoria) {
        final nombreLower = categoria['nombre'].toLowerCase();
        final descripcionLower = categoria['descripcion'].toLowerCase();
        return nombreLower.contains(query.toLowerCase()) || descripcionLower.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/categorias');
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ReposterosScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C1B2F),
        title: Text(
          'Categorías',
          style: GoogleFonts.lora(
            color: const Color(0xFFF2F0E4),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
                          style: GoogleFonts.lora(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categoria['descripcion'],
                          style: GoogleFonts.lora(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _showCategoriaDetalles(context, categoria['nombre']),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: const Color(0xFF8C1B2F),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Pasteles'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Reposteros'),
        ],
        selectedItemColor: Color(0xFFF2F0E4),
        unselectedItemColor: Color(0xFF731D3C),
        backgroundColor: Color(0xFF8C1B2F),
      ),
    );
  }

  void _showCategoriaDetalles(BuildContext context, String categoria) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Detalles de la categoría: $categoria'),
        duration: const Duration(seconds: 2),
      ),
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
      'puntaje': 4.9,
    },
    {
      'nombre': 'Mario Pérez',
      'imagen': 'assets/repostero3.jpg',
      'descripcion': 'Experto en repostería francesa.',
      'estrellas': 4,
      'puntaje': 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C1B2F),
        title: Text(
          'Reposteros',
          style: GoogleFonts.lora(
            color: const Color(0xFFF2F0E4),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                          style: GoogleFonts.lora(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          repostero['descripcion'],
                          style: GoogleFonts.lora(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          style: GoogleFonts.lora(fontSize: 14),
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
}

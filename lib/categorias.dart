import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:borcelle/reposteros.dart';
import 'package:borcelle/Model3D/MainMenuUI.dart';
import 'package:borcelle/home.dart'; // Importación asegurada

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
  int _selectedIndex = 1; // "Pasteles"

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
    if (index == _selectedIndex) return; // Evita recargar la pantalla actual

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Ir a HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // ✅ Sin 'const'
        );
        break;
      case 1: // Categorías (Ya estamos aquí)
        break;
      case 2: // Reposteros
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReposterosScreen()),
        );
        break;
      case 3: // Model 3D
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Model3DViewer()),
        );
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ❌ Elimina la flecha de regreso
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
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'Model 3D'),
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

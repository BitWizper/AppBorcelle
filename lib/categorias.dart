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
  int _selectedIndex = 1; // "Categorías"

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
      Navigator.pushReplacementNamed(context, '/reposteros');
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
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Color(0xFFF2F0E4)),
            onPressed: () {
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag, color: Color(0xFFF2F0E4)),
            onPressed: () {
              Navigator.pushNamed(context, '/pedidos');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFFF2F0E4)),
            onPressed: () {
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Color(0xFFF2F0E4)),
            onPressed: () {
              Navigator.pushNamed(context, '/ayuda');
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF8C1B2F),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF731D3C)),
              child: Text(
                'Menú',
                style: GoogleFonts.lora(
                  color: const Color(0xFFF2F0E4),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFFF2F0E4)),
              title: Text('Inicio', style: GoogleFonts.lora(color: const Color(0xFFF2F0E4))),
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Color(0xFFF2F0E4)),
              title: Text('Categorías', style: GoogleFonts.lora(color: const Color(0xFFF2F0E4))),
              onTap: () => Navigator.pushReplacementNamed(context, '/categorias'),
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Color(0xFFF2F0E4)),
              title: Text('Reposteros', style: GoogleFonts.lora(color: const Color(0xFFF2F0E4))),
              onTap: () => Navigator.pushReplacementNamed(context, '/reposteros'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: Color(0xFFF2F0E4)),
              title: Text('Mis Pedidos', style: GoogleFonts.lora(color: const Color(0xFFF2F0E4))),
              onTap: () => Navigator.pushNamed(context, '/pedidos'),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFFF2F0E4)),
              title: Text('Configuración', style: GoogleFonts.lora(color: const Color(0xFFF2F0E4))),
              onTap: () => Navigator.pushNamed(context, '/configuracion'),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Color(0xFFF2F0E4)),
              title: Text('Ayuda', style: GoogleFonts.lora(color: const Color(0xFFF2F0E4))),
              onTap: () => Navigator.pushNamed(context, '/ayuda'),
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


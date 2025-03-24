import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  List<Map<String, dynamic>> categorias = [];
  Map<String, List<Map<String, dynamic>>> pastelesPorCategoria = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    try {
      // Primero cargar categorías
      final responseCategories = await http.get(
        Uri.parse('http://localhost:3000/api/categoria/obtenercategorias'),
      );

      if (responseCategories.statusCode == 200) {
        final List<dynamic> categoriasData = json.decode(responseCategories.body);
        setState(() {
          categorias = List<Map<String, dynamic>>.from(categoriasData);
        });

        // Luego cargar pasteles
        final responsePasteles = await http.get(
          Uri.parse('http://localhost:3000/api/pastel/obtenerpasteles'),
        );

        if (responsePasteles.statusCode == 200) {
          final List<dynamic> pastelesData = json.decode(responsePasteles.body);
          final Map<String, List<Map<String, dynamic>>> pastelesOrganizados = {};

          // Organizar pasteles por categoría
          for (var categoria in categorias) {
            String nombreCategoria = categoria['nombre'];
            pastelesOrganizados[nombreCategoria] = [];
            
            for (var pastel in pastelesData) {
              if (pastel['id_categoria'] == categoria['id_categoria']) {
                pastelesOrganizados[nombreCategoria]!.add({
                  'nombre': pastel['nombre'] ?? '',
                  'precio': pastel['precio']?.toString() ?? '0.00',
                  'imagen': pastel['imagen_url'] ?? '',
                  'descripcion': pastel['descripcion'] ?? '',
                  'destacado': pastel['destacado'] ?? false,
                });
              }
            }
          }

          setState(() {
            pastelesPorCategoria = pastelesOrganizados;
          });
        }
      }
    } catch (e) {
      print('Error al cargar los datos: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getImagenLocal(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'bodas':
        return 'assets/fotodepasteles/boda.jpg';
      case 'xv años':
        return 'assets/fotodepasteles/fotopastel2.jpeg';
      case 'bautizos':
        return 'assets/fotodepasteles/fotopastel3.jpg';
      case 'baby shower':
        return 'assets/fotodepasteles/fotopastel4.jpg';
      case 'cumpleaños':
        return 'assets/fotodepasteles/fotopastel5.jpg';
      default:
        return 'assets/fotodepasteles/fotopastel1.jpg';
    }
  }

  void navegarADetalleCategoria(BuildContext context, String nombreCategoria, List<Map<String, dynamic>> pasteles) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleCategoriaScreen(
          nombreCategoria: nombreCategoria,
          pasteles: pasteles,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        title: Text(
          "Catálogo de Pasteles",
          style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categorias.map((categoria) {
                  final pasteles = pastelesPorCategoria[categoria['nombre']] ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoria['nombre'],
                              style: GoogleFonts.lora(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF731D3C),
                              ),
                            ),
                            TextButton(
                              onPressed: () => navegarADetalleCategoria(
                                context,
                                categoria['nombre'],
                                pasteles,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Ver más',
                                    style: TextStyle(
                                      color: Color(0xFF8C1B2F),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Color(0xFF8C1B2F),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pasteles.length,
                            itemBuilder: (context, index) {
                              var pastel = pasteles[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2F0E4),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(8)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                          ),
                                          child: Image.asset(
                                            getImagenLocal(categoria['nombre']),
                                            width: 160,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                pastel['nombre'],
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF8C1B2F),
                                                ),
                                              ),
                                              Text(
                                                '\$${double.parse(pastel['precio'].toString()).toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  color: Color(0xFFA65168),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                pastel['descripcion'],
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFFA65168).withOpacity(0.8),
                                                ),
                                              ),
                                            ],
                                          ),
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

class DetalleCategoriaScreen extends StatelessWidget {
  final String nombreCategoria;
  final List<Map<String, dynamic>> pasteles;

  const DetalleCategoriaScreen({
    Key? key,
    required this.nombreCategoria,
    required this.pasteles,
  }) : super(key: key);

  String getImagenLocal(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'bodas':
        return 'assets/fotodepasteles/boda.jpg';
      case 'xv años':
        return 'assets/fotodepasteles/fotopastel2.jpeg';
      case 'bautizos':
        return 'assets/fotodepasteles/fotopastel3.jpg';
      case 'baby shower':
        return 'assets/fotodepasteles/fotopastel4.jpg';
      case 'cumpleaños':
        return 'assets/fotodepasteles/fotopastel5.jpg';
      default:
        return 'assets/fotodepasteles/fotopastel1.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        title: Text(
          nombreCategoria,
          style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: pasteles.length,
        itemBuilder: (context, index) {
          var pastel = pasteles[index];
          return Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    getImagenLocal(nombreCategoria),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pastel['nombre'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF731D3C),
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${double.parse(pastel['precio'].toString()).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        pastel['descripcion'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

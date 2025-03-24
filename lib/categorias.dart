import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  final bool _isAuthenticated = false;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _pasteles = [
    {
      "nombre": "Pastel de Fresas",
      "precio": "\$20.00",
      "repostero": "Chef Ana",
      "imagen": "assets/fotodepasteles/fresas.jpg",
      "reseña": "Un pastel delicioso con fresas frescas.",
      "ingredientes": "Harina, azúcar, fresas, crema."
    },
    {
      "nombre": "Pastel de Chocolate",
      "precio": "\$25.00",
      "repostero": "Chef Juan",
      "imagen": "assets/fotodepasteles/chocolate.jpg",
      "reseña": "Chocolate puro en cada bocado.",
      "ingredientes": "Harina, cacao, azúcar, leche."
    }
  ];
  List<Map<String, String>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = _pasteles;
    _searchController.addListener(() {
      _onSearchChanged(_searchController.text);
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      query = query.toLowerCase();
      _searchResults = _pasteles
          .where((pastel) => pastel["nombre"]!.toLowerCase().contains(query))
          .toList();

      if (_searchResults.isEmpty && query.isNotEmpty) {
        _searchResults = [{"nombre": "No encontrado"}];
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Catálogo de Pasteles", style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildPastelesCatalogo(),
          ],
        ),
      ),
    );
  }

  Widget _buildPastelesCatalogo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nuestros Pasteles",
            style: GoogleFonts.lora(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C1B2F),
            ),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final pastel = _searchResults[index];
              if (pastel["nombre"] == "No encontrado") {
                return Center(child: Text("No encontrado", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)));
              }
              return _buildPastelCard(pastel);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPastelCard(Map<String, String> pastel) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: Image.asset(pastel["imagen"]!, height: 120, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(pastel["nombre"]!,
                    style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF731D3C))),
                Text("Precio: ${pastel["precio"]}", style: TextStyle(fontSize: 14, color: Color(0xFFA65168))),
                Text("Repostero: ${pastel["repostero"]}", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                SizedBox(height: 5),
                Text(pastel["reseña"]!, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA65168),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Ver más", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

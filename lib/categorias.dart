import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  final Map<String, List<Map<String, String>>> categorias = const {
    'XV Años': [
      {
        "nombre": "Pastel de Fresas",
        "precio": "\$20.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Un pastel delicioso con fresas frescas."
      },
      {
        "nombre": "Pastel de Chocolate",
        "precio": "\$25.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Chocolate puro en cada bocado."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },{
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
    ],
    'Bautizos': [
      {
        "nombre": "Pastel de Vainilla",
        "precio": "\$18.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Pastel esponjoso con un toque de vainilla."
      },
      {
        "nombre": "Pastel de Zanahoria",
        "precio": "\$22.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Un pastel saludable con zanahoria y nueces."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },{
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
    ],
    'Bodas': [
      {
        "nombre": "Pastel de 3 pisos",
        "precio": "\$150.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Pastel elegante para bodas con decoraciones únicas."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },{
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
    ],
    'Cumpleaños': [
      {
        "nombre": "Pastel de 3 pisos",
        "precio": "\$150.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Pastel elegante para bodas con decoraciones únicas."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },{
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
    ],
    'Baby Shower': [
      {
        "nombre": "Pastel de 3 pisos",
        "precio": "\$150.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Pastel elegante para bodas con decoraciones únicas."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
      {
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },{
        "nombre": "Pastel Red Velvet",
        "precio": "\$30.00",
        "imagen": "assets/fotodepasteles/fotopastel1.jpg",
        "reseña": "Sabor intenso con queso crema."
      },
    ]
  };

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categorias.entries.map((categoria) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoria.key,
                    style: GoogleFonts.lora(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF731D3C),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoria.value.length,
                      itemBuilder: (context, index) {
                        var pastel = categoria.value[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F0E4),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Color(0xFFA65168), width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: Image.asset(
                                    pastel['imagen']!,
                                    width: 160,
                                    height: 110,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error cargando imagen: $error');
                                      return Container(
                                        width: 160,
                                        height: 110,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        pastel['nombre']!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF731D3C),
                                        ),
                                      ),
                                      Text(
                                        pastel['precio']!,
                                        style: TextStyle(
                                            color: Colors.orange[700],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        pastel['reseña']!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black87),
                                      ),
                                    ],
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

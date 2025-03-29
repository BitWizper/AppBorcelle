import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preguntas Frecuentes - BORCELLE',
      theme: ThemeData(
        primaryColor: Color(0xFF8C1B2F),
        fontFamily: 'Lora',
      ),
      home: HelpScreen(),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        title: Text(
          'Ayuda',
          style: GoogleFonts.lora(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preguntas Frecuentes',
                style: GoogleFonts.lora(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1B2F),
                ),
              ),
              SizedBox(height: 20),
              _buildFAQCard(
                '¿Cómo puedo realizar un pedido?',
                'Para realizar un pedido, primero debes iniciar sesión en tu cuenta. Luego, navega a la sección de pasteles, selecciona el que desees y sigue los pasos del proceso de compra.'
              ),
              _buildFAQCard(
                '¿Cuál es el tiempo de entrega?',
                'El tiempo de entrega varía según la ubicación y el tipo de pastel. Por lo general, las entregas se realizan en un plazo de 24 a 48 horas después de la confirmación del pedido.'
              ),
              _buildFAQCard(
                '¿Puedo personalizar mi pastel?',
                'Sí, ofrecemos opciones de personalización para nuestros pasteles. Puedes elegir el sabor, el tamaño, la decoración y agregar mensajes personalizados.'
              ),
              _buildFAQCard(
                '¿Qué métodos de pago aceptan?',
                'Aceptamos tarjetas de crédito/débito, transferencias bancarias y pagos en efectivo al momento de la entrega.'
              ),
              SizedBox(height: 20),
              Text(
                'Contacto',
                style: GoogleFonts.lora(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1B2F),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F0E4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactItem(Icons.email, 'Email: soporte@borcelle.com'),
                    SizedBox(height: 10),
                    _buildContactItem(Icons.phone, 'Teléfono: (123) 456-7890'),
                    SizedBox(height: 10),
                    _buildContactItem(Icons.location_on, 'Dirección: Av. Principal #123, Ciudad'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQCard(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF2F0E4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFA65168).withOpacity(0.3), width: 1),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            color: Color(0xFF8C1B2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(
                color: Color(0xFFA65168),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF8C1B2F)),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: Color(0xFF8C1B2F),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF731D3C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('Pantalla de Registro',
            style: TextStyle(fontSize: 18, color: Color(0xFF8C1B2F))),
      ),
    );
  }
}

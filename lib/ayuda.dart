import 'package:flutter/material.dart';

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
        title: Row(
          children: [
            Image.asset(
              'assets/fotodepasteles/iconoborcelle.jpg',
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Preguntas Frecuentes', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Color(0xFF731D3C),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFF2F0E4),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildSection('¿Qué es BORCELLE?', 'Es una plataforma en línea que permite diseñar y encargar pasteles personalizados para eventos exclusivos como bodas, quince años y celebraciones especiales.'),
              _buildSection('¿Cómo funciona BORCELLE?', 'Los usuarios pueden crear un pastel único, eligiendo desde los sabores hasta las decoraciones, y ver el diseño en tiempo real mientras eligen las opciones.'),
              _buildSection('¿Puedo elegir al pastelero de mi preferencia?', 'Sí, en la plataforma puedes seleccionar el pastelero de acuerdo a su experiencia, trabajos anteriores y opiniones de otros clientes.'),
              _buildSection('¿Cómo puedo pagar mi pedido?', 'BORCELLE ofrece múltiples métodos de pago seguros, incluyendo tarjetas de crédito, débito y transferencias bancarias.'),
              _buildSection('¿Cuánto tiempo tarda en hacerse un pastel?', 'El tiempo de entrega varía según la complejidad del diseño, pero en general los pasteles están listos en un plazo de 3 a 7 días hábiles.'),
              _buildSection('¿BORCELLE tiene garantía?', 'Sí, BORCELLE garantiza la calidad de los pasteles y ofrece reembolsos en caso de incumplimiento por parte del pastelero.'),
              _buildSection('¿Qué debo hacer si tengo problemas con mi pedido?', 'Puedes ponerte en contacto con nuestro equipo de soporte a través del chat en la aplicación o enviarnos un correo a soporte@borcelle.com.'),
              _buildSection('¿Puedo modificar mi pedido después de confirmarlo?', 'Sí, puedes hacer modificaciones hasta 24 horas después de realizar tu pedido. Luego, las modificaciones estarán sujetas a la disponibilidad del pastelero.'),
              SizedBox(height: 30),
              _buildCTAButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Text(
        'Preguntas Frecuentes',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8C1B2F),
        ),
      ),
    );
  }

  Widget _buildSection(String question, String answer) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Color(0xFFD9B9AD),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF731D3C),
              ),
            ),
            SizedBox(height: 8),
            Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFA65168),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
        child: Text(
          'Comienza ahora',
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
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
      ),
      body: Center(
        child: Text('Pantalla de Registro',
            style: TextStyle(fontSize: 18, color: Color(0xFF8C1B2F))),
      ),
    );
  }
}
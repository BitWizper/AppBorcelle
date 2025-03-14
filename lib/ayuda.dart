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
        primarySwatch: Colors.pink,
        fontFamily: 'Lora', // Cambié la tipografía a Lora
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
            // Logo de BORCELLE
            Image.asset(
              'assets/fotodepasteles/iconoborcelle.jpg', // Ruta del logo en tu proyecto
              height: 40, // Ajusta el tamaño del logo según sea necesario
            ),
            SizedBox(width: 10),
            Text(
              'Preguntas Frecuentes - BORCELLE',
            ),
          ],
        ),
        backgroundColor: Color(0xFF8C1B2F), // Vino oscuro
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSection('¿Qué es BORCELLE?', 'Es una plataforma en línea que permite diseñar y encargar pasteles personalizados para eventos exclusivos como bodas, quince años y celebraciones especiales.'),
              _buildSection('¿Cómo funciona BORCELLE?', 'Los usuarios pueden crear un pastel único, eligiendo desde los sabores hasta las decoraciones, y ver el diseño en tiempo real mientras eligen las opciones.'),
              _buildSection('¿Qué problemas resuelve BORCELLE?', 'Soluciona las dificultades que enfrentan las personas al no encontrar proveedores que ofrezcan pasteles con la calidad, sabor y diseño deseados.'),
              _buildSection('¿Puedo elegir al pastelero de mi preferencia?', 'Sí, en la plataforma puedes seleccionar el pastelero de acuerdo a su experiencia, trabajos anteriores y opiniones de otros clientes.'),
              _buildSection('¿Cómo puedo contactar al pastelero?', 'A través de la plataforma, puedes agendar una cita para degustaciones y comunicarte con el pastelero para coordinar todos los detalles.'),
              _buildSection('¿Cuál es el modelo de negocio de BORCELLE?', 'BORCELLE gana dinero mediante comisiones por pedido, suscripciones de pasteleros y publicidad en la plataforma.'),
              _buildSection('¿Cómo puedo comenzar a usar la plataforma?', 'Solo tienes que registrarte, crear tu pastel personalizado y elegir al pastelero que mejor se adapte a tus necesidades.'),
              _buildSection('¿BORCELLE está disponible para cualquier evento?', 'Está especialmente diseñado para eventos exclusivos como bodas, quince años y celebraciones de alto nivel.'),
              _buildSection('¿Cómo se asegura la calidad de los pasteles?', 'BORCELLE trabaja solo con los mejores pasteleros de la ciudad, quienes tienen un historial comprobado de trabajos anteriores y son altamente calificados.'),
              _buildSection('¿Qué pasa si no estoy satisfecho con el pastel?', 'La plataforma permite coordinar todos los detalles con el pastelero para asegurar que el pastel sea exactamente lo que buscas. Si hay algún problema, trabajamos para solucionarlo.'),
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
        'Preguntas Frecuentes - BORCELLE',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8C1B2F), // Vino oscuro
        ),
      ),
    );
  }

  Widget _buildSection(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C1B2F), // Vino oscuro
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
    );
  }

  Widget _buildCTAButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8C1B2F), // Vino oscuro
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Comienza ahora',
          style: TextStyle(fontSize: 18),
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
        title: Text('Registro'),
        backgroundColor: Color(0xFF8C1B2F), // Vino oscuro
      ),
      body: Center(
        child: Text('Pantalla de Registro'),
      ),
    );
  }
}

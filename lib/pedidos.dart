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
      title: 'Mis Pedidos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Nunito',
      ),
      home: OrdersScreen(),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Control para saber qué sección mostrar
  String currentSection = 'pedidosActivos';

  // Cambiar entre las secciones
  void _showContent(String sectionId) {
    setState(() {
      currentSection = sectionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Pedidos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Sidebar
          Container(
            color: Colors.pink[100],
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    '← Mis Pedidos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                _buildSidebarOption('Pedidos Activos', 'pedidosActivos'),
                _buildSidebarOption('Historial de Pedidos', 'historialPedidos'),
              ],
            ),
          ),
          // Contenido
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('pedidosActivos', 'Pedidos Activos', 'Aquí aparecerán los pedidos en curso.'),
                  _buildSection('historialPedidos', 'Historial de Pedidos', 'Aquí se mostrarán tus pedidos anteriores.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para construir las opciones del sidebar
  Widget _buildSidebarOption(String title, String sectionId) {
    return GestureDetector(
      onTap: () => _showContent(sectionId),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  // Widget para cada sección
  Widget _buildSection(String sectionId, String title, String content) {
    return Visibility(
      visible: currentSection == sectionId,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text(content, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

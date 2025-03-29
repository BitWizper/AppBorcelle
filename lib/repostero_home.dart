import 'package:flutter/material.dart';

class ReposteroHomeScreen extends StatelessWidget {
  const ReposteroHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido Repostero')),
      body: Center(
        child: Text('Esta es la interfaz de un Repostero', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

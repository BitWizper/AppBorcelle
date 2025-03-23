import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'dart:io';

class Model3DViewer extends StatefulWidget {
  const Model3DViewer({super.key});

  @override
  State<Model3DViewer> createState() => _Model3DViewerState();
}

class _Model3DViewerState extends State<Model3DViewer> {
  List<String> modelFiles = [];
  String selectedModel = '';
  Color bizcochoColor = Colors.white;

  @override
  void initState() {
    super.initState();
    loadModels();
  }

  Future<void> loadModels() async {
    try {
      final String modelsPath = 'lib/Model3D/models';
      final models = Directory(modelsPath)
          .listSync()
          .where((file) => file.path.endsWith('.glb'))
          .map((file) => file.path)
          .toList();
      
      setState(() {
        modelFiles = models;
        if (models.isNotEmpty) {
          selectedModel = models[0];
        }
      });
    } catch (e) {
      print('Error al cargar los modelos: $e');
    }
  }

  void cambiarColorBizcocho(String sabor) {
    setState(() {
      switch (sabor) {
        case 'Chocolate':
          bizcochoColor = Color(0xFF4A3728);
          break;
        case 'Fresa':
          bizcochoColor = Color(0xFFFFB5C5);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header rosa con botón de retroceso y logo
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Color(0xFFFFD5E5),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('', style: TextStyle(fontSize: 18)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/fotodepasteles/iconoborcelle.jpg',
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
          // Contenido principal
          Expanded(
            child: Row(
              children: [
                // Área del modelo 3D
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: selectedModel.isNotEmpty
                        ? ModelViewer(
                            src: selectedModel,
                            alt: 'Modelo 3D',
                            autoRotate: true,
                            cameraControls: true,
                            backgroundColor: Colors.white,
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ),
                // Menú lateral derecho
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF5E1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildMenuOption('Pisos/Capas', Icons.cake, () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Seleccionar Pisos'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: modelFiles.map((model) {
                                String pisos = model.split('/').last.split('_')[0];
                                return ListTile(
                                  title: Text('$pisos Piso(s)'),
                                  onTap: () {
                                    setState(() => selectedModel = model);
                                    Navigator.pop(context);
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }),
                      _buildMenuOption('Bizcocho', Icons.color_lens, () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Seleccionar Sabor'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('Chocolate'),
                                  onTap: () {
                                    cambiarColorBizcocho('Chocolate');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text('Fresa'),
                                  onTap: () {
                                    cambiarColorBizcocho('Fresa');
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Botón guardar en la parte inferior
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Color(0xFFFFF5E1),
            child: ElevatedButton(
              onPressed: () {
                // Aquí va la lógica para guardar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDEB887),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Guardar', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(icon, size: 24),
                SizedBox(height: 4),
                Text(title, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
      print('Intentando cargar modelos desde: $modelsPath');
      
      final directory = Directory(modelsPath);
      if (!await directory.exists()) {
        print('El directorio no existe: $modelsPath');
        return;
      }

      final models = directory
          .listSync()
          .where((file) => file.path.endsWith('.fbx'))
          .map((file) => file.path)
          .toList();
      
      print('Modelos encontrados: $models');
      
      if (models.isEmpty) {
        print('No se encontraron archivos .fbx en el directorio');
      }
      
      setState(() {
        modelFiles = models;
        if (models.isNotEmpty) {
          selectedModel = models[0];
          print('Modelo seleccionado: $selectedModel');
        }
      });
    } catch (e) {
      print('Error al cargar los modelos: $e');
      print('Stack trace: ${StackTrace.current}');
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
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1B2F),
        title: Text(
          "Visualizador 3D",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Área del modelo 3D
          Expanded(
            child: Container(
              color: Color(0xFFF2F0E4),
              child: selectedModel.isNotEmpty
                  ? ModelViewer(
                      src: selectedModel,
                      alt: "Modelo 3D de pastel",
                      ar: true,
                      autoRotate: true,
                      cameraControls: true,
                      shadowIntensity: 1,
                      backgroundColor: Color(0xFFF2F0E4),
                      autoPlay: true,
                      cameraOrbit: "45deg 55deg 2.5m",
                      minCameraOrbit: "auto auto 0.1m",
                      maxCameraOrbit: "auto auto 10m",
                      minFieldOfView: "30deg",
                      maxFieldOfView: "45deg",
                      exposure: 1,
                      loading: Loading.eager,
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            "Cargando modelos...",
                            style: TextStyle(
                              color: Color(0xFF8C1B2F),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          // Menú de selección
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFFF2F0E4),
            child: Column(
              children: [
                Text(
                  "Seleccionar Modelo",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8C1B2F),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: modelFiles.length,
                    itemBuilder: (context, index) {
                      String fileName = modelFiles[index].split('/').last;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedModel = modelFiles[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedModel == modelFiles[index]
                                ? Color(0xFF8C1B2F)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFFA65168).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              fileName,
                              style: TextStyle(
                                color: selectedModel == modelFiles[index]
                                    ? Colors.white
                                    : Color(0xFF8C1B2F),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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

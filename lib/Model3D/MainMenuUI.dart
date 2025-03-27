import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Model3DViewer extends StatefulWidget {
  const Model3DViewer({super.key});

  @override
  State<Model3DViewer> createState() => _Model3DViewerState();
}

class _Model3DViewerState extends State<Model3DViewer> {
  List<String> modelFiles = [];
  String selectedModel = '';
  Color bizcochoColor = Colors.white;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadModels();
  }

  Future<void> loadModels() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      // Cargar modelos desde la carpeta Model3D
      final modelsPath = Directory('lib/Model3D/models');
      
      print('Intentando cargar modelos desde: ${modelsPath.path}');
      
      if (!await modelsPath.exists()) {
        print('El directorio no existe: ${modelsPath.path}');
        setState(() {
          errorMessage = 'No se encontró el directorio de modelos';
          isLoading = false;
        });
        return;
      }

      // Buscar archivos .fbx
      final models = await modelsPath
          .list()
          .where((entity) => entity.path.endsWith('.fbx'))
          .map((entity) => entity.path)
          .toList();
      
      print('Modelos encontrados: $models');
      
      if (models.isEmpty) {
        setState(() {
          errorMessage = 'No se encontraron modelos 3D en el directorio.';
          isLoading = false;
        });
        return;
      }
      
      setState(() {
        modelFiles = models;
        selectedModel = models[0];
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar los modelos: $e');
      print('Stack trace: ${StackTrace.current}');
      setState(() {
        errorMessage = 'Error al cargar los modelos: $e';
        isLoading = false;
      });
    }
  }

  void cambiarColorBizcocho(String sabor) {
    setState(() {
      switch (sabor) {
        case 'Chocolate':
          bizcochoColor = const Color(0xFF4A3728);
          break;
        case 'Fresa':
          bizcochoColor = const Color(0xFFFFB5C5);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C1B2F),
        title: const Text(
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
              color: const Color(0xFFF2F0E4),
              child: isLoading
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8C1B2F)),
                          ),
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
                    )
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Color(0xFF8C1B2F),
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  errorMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF8C1B2F),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: loadModels,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8C1B2F),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Reintentar'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : selectedModel.isNotEmpty
                          ? ModelViewer(
                              src: selectedModel,
                              alt: "Modelo 3D de pastel",
                              ar: true,
                              autoRotate: true,
                              cameraControls: true,
                              shadowIntensity: 1,
                              backgroundColor: const Color(0xFFF2F0E4),
                              autoPlay: true,
                              cameraOrbit: "45deg 55deg 2.5m",
                              minCameraOrbit: "auto auto 0.1m",
                              maxCameraOrbit: "auto auto 10m",
                              minFieldOfView: "30deg",
                              maxFieldOfView: "45deg",
                              exposure: 1,
                              loading: Loading.eager,
                            )
                          : const Center(
                              child: Text(
                                "No hay modelos disponibles",
                                style: TextStyle(
                                  color: Color(0xFF8C1B2F),
                                  fontSize: 16,
                                ),
                              ),
                            ),
            ),
          ),
          // Menú de selección
          if (!isLoading && errorMessage.isEmpty && modelFiles.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF2F0E4),
              child: Column(
                children: [
                  const Text(
                    "Seleccionar Modelo",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8C1B2F),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selectedModel == modelFiles[index]
                                  ? const Color(0xFF8C1B2F)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFA65168).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                fileName,
                                style: TextStyle(
                                  color: selectedModel == modelFiles[index]
                                      ? Colors.white
                                      : const Color(0xFF8C1B2F),
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

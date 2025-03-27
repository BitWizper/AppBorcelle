import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Model3DViewer extends StatefulWidget {
  const Model3DViewer({super.key});

  @override
  State<Model3DViewer> createState() => _Model3DViewerState();
}

class _Model3DViewerState extends State<Model3DViewer> {
  bool isLoading = true;
  String errorMessage = '';
  String selectedModel = '';

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      // Usar un modelo 3D de ejemplo en línea
      selectedModel = 'https://modelviewer.dev/shared-assets/models/cube.glb';
      
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar el modelo: $e');
      print('Stack trace: ${StackTrace.current}');
      setState(() {
        errorMessage = 'Error al cargar el modelo: $e';
        isLoading = false;
      });
    }
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
      body: Container(
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
                      "Cargando modelo...",
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
                            onPressed: loadModel,
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
                : ModelViewer(
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
                  ),
      ),
    );
  }
}

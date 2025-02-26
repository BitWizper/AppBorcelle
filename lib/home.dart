import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text("Borcelle"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Aquí puedes definir qué hacer cuando se selecciona una opción
              switch (value) {
                case 'Mi Perfil':
                  // Aquí puedes redirigir a la pantalla de perfil
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Mi Perfil'),
                      content: Text('Redirigiendo a la pantalla de perfil...'),
                    ),
                  );
                  break;
                case 'Mis Pedidos':
                  // Redirigir a la pantalla de pedidos
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Mis Pedidos'),
                      content: Text('Redirigiendo a la pantalla de pedidos...'),
                    ),
                  );
                  break;
                case 'Centro de Ayuda':
                  // Redirigir al centro de ayuda
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Centro de Ayuda'),
                      content: Text('Redirigiendo al centro de ayuda...'),
                    ),
                  );
                  break;
                case 'Configuración':
                  // Redirigir a la pantalla de configuración
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Configuración'),
                      content: Text('Redirigiendo a la pantalla de configuración...'),
                    ),
                  );
                  break;
                case 'Cerrar Sesión':
                  // Aquí puedes manejar el cierre de sesión
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Cerrar Sesión'),
                      content: Text('¿Estás seguro que deseas cerrar sesión?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Aquí agregarías la lógica de cierre de sesión
                            Navigator.of(context).pop();
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Mi Perfil',
                  child: Text('Mi Perfil'),
                ),
                PopupMenuItem<String>(
                  value: 'Mis Pedidos',
                  child: Text('Mis Pedidos'),
                ),
                PopupMenuItem<String>(
                  value: 'Centro de Ayuda',
                  child: Text('Centro de Ayuda'),
                ),
                PopupMenuItem<String>(
                  value: 'Configuración',
                  child: Text('Configuración'),
                ),
                PopupMenuItem<String>(
                  value: 'Cerrar Sesión',
                  child: Text('Cerrar Sesión'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20), // Espacio arriba
            Text(
              "Pasteles Destacados",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true, // Ajusta el tamaño del GridView
                physics: NeverScrollableScrollPhysics(), // Evita conflicto de scroll
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: 4, // Número de pasteles destacados
                itemBuilder: (context, index) {
                  List<Map<String, String>> cakes = [
                    {
                      "image": "https://i.pinimg.com/736x/8d/4d/20/8d4d20b75a8d8b13e3d2907c5c58e633.jpg",
                      "name": "Pastel de Fresas",
                      "price": "250 MXN"
                    },
                    {
                      "image": "https://i.pinimg.com/736x/4a/5b/2a/4a5b2a3f6c2e6eae4f0e53ad43ebf3bb.jpg",
                      "name": "Pastel de Chocolate",
                      "price": "220 MXN"
                    },
                    {
                      "image": "https://i.pinimg.com/736x/3d/4e/29/3d4e29f09b4a4b95b3e8c586fa0a2f74.jpg",
                      "name": "Pastel Arcoíris",
                      "price": "270 MXN"
                    },
                    {
                      "image": "https://i.pinimg.com/736x/2c/3e/17/2c3e17980b30a4e8a7eaf0d44f7dfc5e.jpg",
                      "name": "Pastel Red Velvet",
                      "price": "300 MXN"
                    },
                  ];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              cakes[index]["image"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cakes[index]["name"]!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(cakes[index]["price"]!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

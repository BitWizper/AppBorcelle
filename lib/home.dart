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
              // Aquí navegamos a las pantallas correspondientes
              switch (value) {
                case 'Mi Perfil':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  break;
                case 'Mis Pedidos':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersScreen()),
                  );
                  break;
                case 'Centro de Ayuda':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpScreen()),
                  );
                  break;
                case 'Configuración':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                  break;
                case 'Cerrar Sesión':
                  // Aquí agregarías la lógica para cerrar sesión
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
                            // Agrega la lógica para cerrar sesión
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
            SizedBox(height: 20),
            Text(
              "Pasteles Destacados",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<Map<String, String>> cakes = [
                    {
                      "image": "assets/fotodepasteles/fotopastel1.jpg",
                      "name": "Pastel de Fresas",
                      "price": "250 MXN"
                    },
                    {
                      "image": "assets/fotodepasteles/fotopastel2.jpeg",
                      "name": "Pastel de Chocolate",
                      "price": "220 MXN"
                    },
                    {
                      "image": "assets/fotodepasteles/fotopastel3.jpg",
                      "name": "Pastel Arcoíris",
                      "price": "270 MXN"
                    },
                    {
                      "image": "assets/fotodepasteles/fotopastel4.jpg",
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

// Pantallas de navegación (simples para demostración)

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mi Perfil")),
      body: Center(child: Text("Pantalla de perfil")),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mis Pedidos")),
      body: Center(child: Text("Pantalla de pedidos")),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Centro de Ayuda")),
      body: Center(child: Text("Pantalla de ayuda")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración")),
      body: Center(child: Text("Pantalla de configuración")),
    );
  }
}

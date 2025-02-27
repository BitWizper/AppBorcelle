import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Índice de la pestaña activa

  void _onItemTapped(int index) {
  if (_selectedIndex == index) return; // Evitar recargas innecesarias
  setState(() {
    _selectedIndex = index;
  });

  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/home'); // Mantiene el historial de navegación
      break;
    case 1:
      Navigator.pushNamed(context, '/catalogo_pasteles');
      break;
    case 2:
      Navigator.pushNamed(context, '/catalogo_reposteros');
      break;
    case 3:
      Navigator.pushNamed(context, '/crear_pastel');
      break;
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar pasteles...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Mi Perfil':
                  Navigator.pushNamed(context, '/perfil');
                  break;
                case 'Mis Pedidos':
                  Navigator.pushNamed(context, '/pedidos');
                  break;
                case 'Centro de Ayuda':
                  Navigator.pushNamed(context, '/ayuda');
                  break;
                case 'Configuración':
                  Navigator.pushNamed(context, '/configuracion');
                  break;
                case 'Cerrar Sesión':
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Cerrar Sesión'),
                      content: Text('¿Estás seguro que deseas cerrar sesión?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
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
                PopupMenuItem(value: 'Mi Perfil', child: Text('Mi Perfil')),
                PopupMenuItem(value: 'Mis Pedidos', child: Text('Mis Pedidos')),
                PopupMenuItem(value: 'Centro de Ayuda', child: Text('Centro de Ayuda')),
                PopupMenuItem(value: 'Configuración', child: Text('Configuración')),
                PopupMenuItem(value: 'Cerrar Sesión', child: Text('Cerrar Sesión')),
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
                    {"image": "assets/fotodepasteles/fotopastel1.jpg", "name": "Pastel de Fresas", "price": "250 MXN"},
                    {"image": "assets/fotodepasteles/fotopastel2.jpeg", "name": "Pastel de Chocolate", "price": "220 MXN"},
                    {"image": "assets/fotodepasteles/fotopastel3.jpg", "name": "Pastel Arcoíris", "price": "270 MXN"},
                    {"image": "assets/fotodepasteles/fotopastel4.jpg", "name": "Pastel Red Velvet", "price": "300 MXN"},
                  ];

                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Índice para mantener el estado
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Pasteles'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Reposteros'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Crear Pastel'),
        ],
        selectedItemColor: Colors.pink[300],
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

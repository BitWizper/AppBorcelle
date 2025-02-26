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
      title: 'Catálogo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Poppins',
      ),
      home: CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'XV Años', 'image': 'assets/xv_anos.jpg'},
    {'title': 'Boda', 'image': 'assets/boda.jpg'},
    {'title': 'Babyshower', 'image': 'assets/babyshower.jpg'},
    {'title': 'Cumpleaños', 'image': 'assets/cumpleanos.jpg'},
    {'title': 'Bautizo', 'image': 'assets/bautizo.jpg'},
  ];

  // Se eliminó `const` para evitar el error
  CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.cake, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text('Menú', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Home'), onTap: () {}),
            ListTile(leading: Icon(Icons.person), title: Text('Mi Perfil'), onTap: () {}),
            ListTile(leading: Icon(Icons.help), title: Text('Centro de Ayuda'), onTap: () {}),
            ListTile(leading: Icon(Icons.settings), title: Text('Configuración'), onTap: () {}),
            ListTile(leading: Icon(Icons.logout), title: Text('Cerrar Sesión'), onTap: () {}),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        categories[index]['image']!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categories[index]['title']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categorías'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

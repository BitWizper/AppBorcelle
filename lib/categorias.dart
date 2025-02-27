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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/catalogo_pasteles': (context) => CatalogScreen(type: 'pasteles'),
        '/catalogo_reposteros': (context) => CatalogScreen(type: 'reposteros'),
        '/crear_pastel': (context) => const CreateCakeScreen(),
      },
    );
  }
}

class CatalogScreen extends StatelessWidget {
  final String type;
  
  // Constructor
  CatalogScreen({super.key, required this.type});

  // Listas para los catálogos
  final List<Map<String, String>> pastelCategories = [
    {'title': 'XV Años', 'image': 'assets/fotodeiconos/iconodequinceaños.jpg'},
    {'title': 'Boda', 'image': 'assets/fotodeiconos/iconodeboda.jpg'},
    {'title': 'Babyshower', 'image': 'assets/fotodeiconos/iconodebabyshower.png'},
    {'title': 'Cumpleaños', 'image': 'assets/fotodeiconos/iconodecumpleaños.jpg'},
    {'title': 'Bautizo', 'image': 'assets/fotodeiconos/iconodebautizo.png'},
  ];

  final List<Map<String, String>> reposteroCategories = [
    {'title': 'Repostero A', 'image': 'assets/fotodeiconos/iconodepasteleroA.jpg'},
    {'title': 'Repostero B', 'image': 'assets/fotodeiconos/iconodepasteleroB.jpg'},
    {'title': 'Repostero C', 'image': 'assets/fotodeiconos/iconodepasteleroC.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    // Selecciona la lista correcta según el tipo
    List<Map<String, String>> categories = (type == 'pasteles') ? pastelCategories : reposteroCategories;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: type == 'pasteles' ? 'Buscar pasteles...' : 'Buscar reposteros...',
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
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.pink),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.cake, color: Colors.white, size: 50),
                  const SizedBox(height: 10),
                  const Text('Menú', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
            ),
            ListTile(leading: const Icon(Icons.person), title: const Text('Mi Perfil'), onTap: () {}),
            ListTile(leading: const Icon(Icons.help), title: const Text('Centro de Ayuda'), onTap: () {}),
            ListTile(leading: const Icon(Icons.settings), title: const Text('Configuración'), onTap: () {}),
            ListTile(leading: const Icon(Icons.logout), title: const Text('Cerrar Sesión'), onTap: () {}),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Pasteles'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Reposteros'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Crear Pastel'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: const Center(child: Text('Bienvenido al HomeScreen')),
    );
  }
}

class CreateCakeScreen extends StatelessWidget {
  const CreateCakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Pastel')),
      body: const Center(child: Text('Aquí puedes crear un pastel personalizado')),
    );
  }
}

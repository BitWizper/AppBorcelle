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
      title: 'Mi Carrito - Borcelle',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Nunito',
      ),
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatelessWidget {
  // Simulando productos en el carrito
  final List<Map<String, String>> cartItems = [
    {
      'name': 'Pastel de Chocolate',
      'image': 'https://via.placeholder.com/150',
      'price': '\$25.00',
    },
    {
      'name': 'Pastel de Fresas',
      'image': 'https://via.placeholder.com/150',
      'price': '\$30.00',
    },
    {
      'name': 'Tarta de Limón',
      'image': 'https://via.placeholder.com/150',
      'price': '\$20.00',
    },
  ];

  // Se eliminó `const` para evitar el error
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
        backgroundColor: Colors.pink[300],
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la página
            Text(
              'Carrito de Compras',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink[300],
              ),
            ),
            SizedBox(height: 20),
            // Lista de productos en el carrito
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemWidget(cartItems[index]);
                },
              ),
            ),
            // Total y botón de checkout
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: \$75.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Proceder al pago',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Map<String, String> item;

  const CartItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.network(
              item['image']!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item['price']!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.pink[300],
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Lógica para eliminar el producto del carrito
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
        backgroundColor: Colors.pink[300],
      ),
      body: Center(
        child: Text('Pantalla de Perfil'),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        if (index == 0) {
          // Navigate to the cart screen (already on it)
        } else if (index == 1) {
          // Navigate to the home screen
        } else if (index == 2) {
          // Navigate to the profile screen
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Carrito',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
    );
  }
}

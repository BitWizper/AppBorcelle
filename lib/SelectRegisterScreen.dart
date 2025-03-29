import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(SelectRegisterApp());
}

class SelectRegisterApp extends StatelessWidget {
  const SelectRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/register': (context) => RegisterScreen(), // Define la ruta para /register
        '/registerRepostero': (context) => RegisterReposteroScreen(), // Define la ruta para /registerRepostero
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SelectRegisterScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://your-image-url.com/logo.png', width: 150),
            SizedBox(height: 20),
            Text('Loading ... Please Wait', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class SelectRegisterScreen extends StatelessWidget {
  const SelectRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/736x/be/99/c4/be99c4ada20cedd3ded33bcf9e53374f.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(24.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFF8F1E7),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Color(0xFFA63D40), size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    'Borcelle',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA63D40),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lo hace posible',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Regístrate como:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA63D40),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Cliente', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA63D40),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/registerRepostero');
                    },
                    child: Text('Repostero', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Define las pantallas de registro que serán usadas en las rutas
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro Cliente')),
      body: Center(child: Text('Pantalla de registro para Cliente')),
    );
  }
}

class RegisterReposteroScreen extends StatelessWidget {
  const RegisterReposteroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro Repostero')),
      body: Center(child: Text('Pantalla de registro para Repostero')),
    );
  }
}

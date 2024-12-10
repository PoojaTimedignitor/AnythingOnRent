import 'package:flutter/material.dart';

import 'detalissss.dart';

void main() {
  runApp(BlinkitAnimationApp());
}

class BlinkitAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'id': '1', 'name': 'Product 1', 'image': 'assets/images/home.png'},
    {'id': '2', 'name': 'Product 2', 'image': 'assets/images/home.png'},
    {'id': '3', 'name': 'Product 3', 'image': 'assets/images/home.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blinkit Animation Example'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 600),
                  reverseTransitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) => DetailScreenss(product: product),
                  transitionsBuilder:
                      (_, animation, secondaryAnimation, child) {
                    var curve = Curves.easeInOut;
                    var tween = Tween(begin: 0.0, end: 1.0)
                        .chain(CurveTween(curve: curve));
                    return FadeTransition(
                      opacity: animation.drive(tween),
                      child: ScaleTransition(
                        scale: animation.drive(tween),
                        child: child,
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Hero(
                    tag: product['id']!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        product['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    product['name']!,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

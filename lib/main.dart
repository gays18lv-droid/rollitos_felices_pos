import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(const RollitosPOS());
}

class RollitosPOS extends StatelessWidget {
  const RollitosPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rollitos Felices Sushi',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.redAccent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.redAccent,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Product> products = [
    Product("California", 95),
    Product("Empanizado", 100),
    Product("Yakimeshi Pollo", 140),
    Product("Paquete 1", 115),
    Product("Refresco", 15),
  ];

  final List<Product> cart = [];

  double get total =>
      cart.fold(0, (sum, item) => sum + item.price);

  void addProduct(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  void clearCart() {
    setState(() {
      cart.clear();
    });
  }

  String get currentDate =>
      DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rollitos Felices Sushi"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[850],
                  ),
                  onPressed: () => addProduct(product),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: 18)),
                      Text("\$${product.price}",
                          style: const TextStyle(
                              fontSize: 16)),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text("Orden",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return Text(
                            "${item.name} - \$${item.price}");
                      },
                    ),
                  ),
                  const Divider(),
                  Text("Total: \$${total.toStringAsFixed(2)}",
                      style:
                          const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: cart.isEmpty
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  AlertDialog(
                                title: const Text(
                                    "Venta realizada"),
                                content: Text(
                                    "Fecha: $currentDate\nTotal: \$${total.toStringAsFixed(2)}\n\nGracias por su preferencia"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context);
                                      clearCart();
                                    },
                                    child:
                                        const Text("OK"),
                                  )
                                ],
                              ),
                            );
                          },
                    child: const Text("Cobrar"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

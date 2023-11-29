import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:products_app/screens/loading_screen.dart';
import 'package:provider/provider.dart';

import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productService.isLoading) return const LoadingScrenn();
    var products = productService.products;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            }, 
            icon: const Icon(Icons.logout_outlined)
          ),
        ],
        
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
          child: ProductCard(product: products[index],),
          onTap: () {
            productService.selectedProduct = products[index].copy();
            Navigator.pushNamed(context, 'product');
          }
        );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectedProduct = _createDefaultProduct();
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Product _createDefaultProduct() {
    return Product(
      available: false, 
      name: '', 
      price: 0
    );
  }
}

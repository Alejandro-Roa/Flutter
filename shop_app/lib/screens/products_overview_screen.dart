import 'package:flutter/material.dart';

import '../wigdets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // does not need to rebuild, outsource gridView 'extracted
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: const ProductsGrid(), // using provider 
    );
  }
}



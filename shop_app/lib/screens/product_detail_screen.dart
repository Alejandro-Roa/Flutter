import 'package:flutter/material.dart';
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {

    // avoid fordwarding data to a widget to then be used in another widget
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    

    // provider package
    return Scaffold(
      appBar: AppBar(
        title: const Text('bruh'),
      ),
    );
  }
}
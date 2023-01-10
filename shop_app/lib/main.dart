import 'package:flutter/material.dart';

// to register a provider
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // different providers, this class will listen to the provider class
    // this provider class only works with objects based on classes that use the ChangeNotifier mixin 'common use-case'
    return ChangeNotifierProvider(
      // wrapped by provider widget
      //  builder method accepted with a provider <= 4.0
      create: (ctx) => Products(), // should return instance of provided class
      // all childrens can set up a listener to Products, only those will be rebuilde
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: const ProductsOverviewScreen(),
        // defining routes
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        },
      ),
    );
  }
}

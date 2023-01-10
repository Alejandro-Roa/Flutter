import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import './product_item.dart';

// extracted widget
class ProductsGrid extends StatelessWidget {
  // no constructor needed, data will be fetched using a listerner
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  // provided widget tree will only be rebuilded whenever it changes, parent will not rerun
  @override
  Widget build(BuildContext context) {
    // used in a widget with direct or indirect parent widget set with a provider, hence main
    // of context allow to change provide object

    // <genericMethod> type of data it'll listen to
    // telling provider to stablish a direct communication to the provided instace of the Products Class
    final productsData = Provider.of<Products>(
        context); // direct comunication channel to one of the provided classes
    final products = productsData.items;

    return GridView.builder(
      // optimizes amount of items being loaded
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // columns
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10), // structure
      itemBuilder: (context, index) => ProductItem(
        // data is forwarded once, therefore, state management its ok
        products[index].id,
        products[index].title,
        products[index].imageUrl,
      ),
      itemCount: products.length,
    );
  }
}

// mixin are like interfaces on Java
// used to add utilities or functions with a less strong relation than inheritance
// a class can have as many mix ins as needed unlike extends 'only one'



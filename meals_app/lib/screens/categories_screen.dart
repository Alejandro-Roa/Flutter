import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../categories_props.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  // builder mode dynamic amount
  Widget build(BuildContext context) {
    // return Scaffold( // not needed duplicate appBar
    //   appBar: AppBar(
    //     title: const Text('Meals App'),
    //   ),
    //   body:
    return GridView(
      padding: const EdgeInsets.all(25),
      children: CAT_PROPS
          .map((catData) => CategoryItem(
              title: catData.title, color: catData.color, id: catData.id))
          .toList(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    );
  }
}

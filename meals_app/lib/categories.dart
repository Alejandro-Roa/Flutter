import 'package:flutter/material.dart';

import './categories_template.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  // builder mode dinamic amount 
  Widget build(BuildContext context) {
    return GridView(children: <Widget>[


    ], gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20
      ),
    );
  }
}
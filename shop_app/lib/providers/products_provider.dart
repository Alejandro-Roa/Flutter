import 'package:flutter/material.dart';

// define provider class to then be used to specific widgets being managed in the 
// highest possible point of all the involved widgets 

import '../models/product.dart';

// add mix-in after the class name 'sorta extending another class or merging'
// change notifier is a widget to help stablish a comunication between context and provider
class Products with ChangeNotifier {
  // prop not accesible from outside
  final List<Product>  _items =  [ // set to final //??
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // adding a getter
  List<Product> get items {
    // copy of does not contain same address as _items, a copy can know what items changed
    return [..._items]; 
  }

  // call listeners to trigger provider
  void addProduct() {
   // _items.add(value);

    // from ChangeNotifier update widgets depending on state
    notifyListeners();
  }
}
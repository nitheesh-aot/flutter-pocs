import 'package:flutter/material.dart';
import 'models/product.dart';
import 'shoppinglist.dart';

class MyShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(primaryColor: Colors.redAccent),
      home: ShoppingList(
        products: <Product>[
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate chips'),
          Product(name: 'Bacon'),
        ],
      ),
    );
  }
}

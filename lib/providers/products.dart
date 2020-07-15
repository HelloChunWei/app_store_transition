import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _item = [
    Product(id: 'image1', image: 'assets/img/image1.jpg'),
    Product(id: 'image2', image: 'assets/img/image2.jpg'),
    Product(id: 'image3', image: 'assets/img/image3.jpg'),
  ];
  List<Product> get item {
    return [..._item];
  }

  Product findById(String id) {
    return _item.firstWhere((product) => product.id == id);
  }
}

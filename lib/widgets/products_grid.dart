import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false).item;
    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) {
        return ProductItem(products[i]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 50,
        mainAxisSpacing: 30,
      ),
    );
  }
}

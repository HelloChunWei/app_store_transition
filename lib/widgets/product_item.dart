import 'package:app_store_transition/models/product.dart';
import 'package:flutter/material.dart';
import '../screen/product_detail_screen.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  ProductItem(this.product);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            /// [opaque] set fasle, then the detail page can see the home page screen.
            opaque: false,
            transitionDuration: Duration(milliseconds: 700),
            fullscreenDialog: true,
            pageBuilder: (context, _, __) => ProductDetailScreen(),
            settings: RouteSettings(arguments: widget.product.id),
          ),
        );
      },
      child: Hero(
        tag: widget.product.id,
        child: Image.asset(widget.product.image, fit: BoxFit.cover),
        flightShuttleBuilder:
            (flightContext, animation, direction, fromcontext, toContext) {
          final Hero toHero = toContext.widget;
          // Change push and pop animation.
          return direction == HeroFlightDirection.push
              ? ScaleTransition(
                  scale: animation.drive(
                    Tween<double>(
                      begin: 0.75,
                      end: 1.02,
                    ).chain(
                      CurveTween(
                          curve: Interval(0.4, 1.0, curve: Curves.easeInOut)),
                    ),
                  ),
                  child: toHero.child,
                )
              : SizeTransition(
                  sizeFactor: animation,
                  child: toHero.child,
                );
        },
      ),
    );
  }
}

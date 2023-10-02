import 'package:app_store_transition/models/product.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import '../screen/product_detail_screen.dart';
import '../screen//product_detail_2023.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  ProductItem(this.product);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  BorderSide side = BorderSide(color: Colors.white);
  @override
  // we can use [OpenContainer] to replace [Hero] widget at 2023.
  /*
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback closeContainer) {
        return ProductDetailScreen2023(widget.product, closeContainer);
      },
      tappable: false,
      transitionDuration: Duration(milliseconds: 2000),
      openShape: RoundedRectangleBorder(
      ),
      openColor: Colors.white.withOpacity(0.6),
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return GestureDetector(
          onTap: () => {
            openContainer()
            //  Navigator.of(_).push(
            //   PageRouteBuilder(
            //     /// [opaque] set fasle, then the detail page can see the home page screen.
            //     opaque: false,
            //     transitionDuration: Duration(milliseconds: 700),
            //     fullscreenDialog: true,
            //     pageBuilder: (context, _, __) => ProductDetailScreen2023(widget.product, openContainer),
            //     settings: RouteSettings(arguments: widget.product.id),
            //   ),
            // )
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(widget.product.image, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
  */
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
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(widget.product.image, fit: BoxFit.cover),
          ),
        ),
        flightShuttleBuilder:
            (flightContext, animation, direction, fromcontext, toContext) {
          final Widget toHero = toContext.widget;
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
                  child: toHero,
                )
              : SizeTransition(
                  sizeFactor: animation,
                  child: toHero,
                );
        },
      ),
    );
  }
}

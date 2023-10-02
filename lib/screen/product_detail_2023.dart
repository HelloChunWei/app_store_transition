import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_store_transition/models/product.dart';

class ProductDetailScreen2023 extends StatefulWidget {
  final Product product;
  final VoidCallback openContainer;
  ProductDetailScreen2023(this.product, this.openContainer);
  @override
  _ProductDetailScreen2023State createState() => _ProductDetailScreen2023State();
}

class _ProductDetailScreen2023State extends State<ProductDetailScreen2023> with TickerProviderStateMixin {
  final String _text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
      'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
      'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
      'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
      'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
      'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
      'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
      'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
      'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
      'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
      'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
      'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
      'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
      'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
      'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
      'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n';

  /// [_closeController] controls transition when router pops.
  AnimationController? _closeController;
  Animation? _closeAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _closeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _closeAnimation =
        Tween<double>(begin: 1.0, end: 0.5).animate(_closeController!);



    super.initState();
  }
   @override
  void dispose() {
    _closeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: AnimatedBuilder(
         animation: _closeAnimation!,
        builder: (contex, _child) {
          // only trigger at router pop.
          return Transform.scale(
            scale: _closeAnimation!.value,
            child: _child,
          );
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Listener(
             onPointerDown: (opm) {
              print(opm.position.dy);
            },
            onPointerUp: (opm) {
              print(opm.position.dy);
            },
            onPointerMove: (opm) {
               _closeController!.fling(velocity: 1).then((_) {
                widget.openContainer();
              });
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 300,
                  // hide the back button
                  leading: Container(),
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        widget.product.image,
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 50, bottom: 30),
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Text('Title', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 30),
                            Text(_text,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

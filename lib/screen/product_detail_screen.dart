import 'dart:async';

import 'package:app_store_transition/models/product.dart';
import 'package:app_store_transition/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  AnimationController _heightController;
  AnimationController _widthController;
  AnimationController _closeController;
  double _initPoint;
  double _pointerDistance;
  Product _product;
  String _text =
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
      'vitae.\n';
  Animation _closeAnimation;
  bool _pop;
  @override
  void initState() {
    _pop = true;
    print('init');
    _heightController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _closeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    super.initState();
    Timer(Duration(milliseconds: 50), () {
      setState(() {
        _heightController.forward();
        _widthController.forward();
      });
    });
    _closeAnimation =
        Tween<double>(begin: 1.0, end: 0.75).animate(_closeController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context).settings.arguments as String;
    _product = Provider.of<Products>(context, listen: false).findById(id);
  }

  @override
  void dispose() {
    _closeController.dispose();
    _heightController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            // current scroll position.
            // print(scrollNotification.metrics.pixels);
          }
          return true;
        },
        child: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: _closeAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _closeAnimation.value,
                child: child,
              );
            },
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onVerticalDragDown: (detail) {
                    _initPoint = detail.globalPosition.dy;
                  },
                  onVerticalDragUpdate: (detail) {
                    _pointerDistance = detail.globalPosition.dy - _initPoint;
                    if (_pointerDistance >= 0 && _pointerDistance < 200) {
                      // scroll up
                      if (_pointerDistance < 100) {
                        double _scaleValue = double.parse(
                            (_pointerDistance / 100).toStringAsFixed(2));
                        _closeController.animateTo(_scaleValue,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      }
                      // 100 - scale = 0.75
                      // max 100
                      // 1 - scale = 1
                    } else if (_pointerDistance >= 260) {
                      if (_pop) {
                        _pop = false;
                        _closeController.fling(velocity: 1).then((_) {
                          setState(() {
                            _heightController.reverse();
                          });
                          Timer(Duration(milliseconds: 100), () {
                            Navigator.of(context).pop();
                          });
                        });
                      }
                    } else {
                      // scroll down
                    }
                  },
                  onVerticalDragEnd: (detail) {
                    print('end $_pointerDistance');
                    if (_pointerDistance >= 550) {
                      if (_pop) {
                        _closeController.fling(velocity: 1).then((_) {
                          setState(() {
                            _heightController.reverse();
                          });
                          Timer(Duration(milliseconds: 100), () {
                            Navigator.of(context).pop();
                          });
                        });
                      }
                    } else {
                      _closeController.fling(velocity: -1);
                    }
                  },
                  onTap: () {
                    // _closeCOntroller.forward().then((_) {
                    // setState(() {
                    // _heightController.fling(velocity: -1);
                    // });
                    // Timer(Duration(milliseconds: 100), () {
                    // Navigator.of(context).pop();
                    // });
                    // });
                  },
                  child: Hero(
                    tag: _product.id,
                    child: Image.asset(
                      _product.image,
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  ),
                ),
                SizeTransition(
                  axis: Axis.horizontal,
                  sizeFactor: Tween<double>(begin: 0.5, end: 1).animate(
                    CurvedAnimation(
                        curve: Curves.easeInOut, parent: _widthController),
                  ),
                  child: SizeTransition(
                    sizeFactor: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                          curve: Curves.easeInOut, parent: _heightController),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 50, bottom: 30),
                      width: double.infinity,
                      color: Colors.white,
                      constraints: BoxConstraints(
                        minHeight: 650,
                      ),
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

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

  AnimationController _heightController;
  AnimationController _closeController;
  double _initPoint;
  double _pointerDistance;
  Product _product;
  Animation _closeAnimation;
  Animation _heightAnimation;
  Animation _heightBackAnimation;
  bool _needPop;
  bool _isTop;
  bool _opactity;
  @override
  void initState() {
    _heightController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _closeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _needPop = true;
    _isTop = false;
    _opactity = false;
    super.initState();
    _heightController.forward();
    Timer(Duration(milliseconds: 250), () {
      setState(() {
        _opactity = true;
      });
    });
    _closeAnimation =
        Tween<double>(begin: 1.0, end: 0.75).animate(_closeController);
    _heightAnimation = Tween<double>(begin: .9, end: 1).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: _heightController));
    _heightBackAnimation = Tween<double>(begin: 0.6, end: 1).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: _heightController));
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: AnimatedBuilder(
        animation: _closeAnimation,
        builder: (contex, _child) {
          return Transform.scale(
            scale: _closeAnimation.value,
            child: _child,
          );
        },
        child: AnimatedOpacity(
          opacity: _opactity ? 1 : 0,
          duration: Duration(milliseconds: 150),
          child: SizeTransition(
            sizeFactor: _needPop ? _heightAnimation : _heightBackAnimation,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 300,
              ),
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
                  _initPoint = opm.position.dy;
                },
                onPointerUp: (opm) {
                  if (_needPop) _closeController.reverse();
                },
                onPointerMove: (opm) {
                  _pointerDistance = -_initPoint + opm.position.dy;
                  if (_pointerDistance >= 0) {
                    // scroll up
                    if (_isTop == true && _pointerDistance < 100) {
                      double _scaleValue = double.parse(
                          (_pointerDistance / 100).toStringAsFixed(2));
                      _closeController.animateTo(_scaleValue,
                          duration: Duration(milliseconds: 0),
                          curve: Curves.linear);
                    } else if (_isTop == true &&
                        _pointerDistance >= 100 &&
                        _pointerDistance < 130) {
                      // stop animation
                      _closeController.animateTo(1,
                          duration: Duration(milliseconds: 0),
                          curve: Curves.linear);
                    } else if (_isTop == true && _pointerDistance >= 130) {
                      if (_needPop) {
                        // pop
                        _needPop = false;
                        _closeController.fling(velocity: 1).then((_) {
                          _heightController.reverse();
                          Navigator.of(context).pop();
                          _opactity = false;
                          Timer(Duration(microseconds: 1000), () {});
                        });
                      }
                    }
                  } else {
                    // scroll down
                    setState(() {
                      _isTop = false;
                    });
                  }
                },
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      double scrollDistance = scrollNotification.metrics.pixels;
                      if (scrollDistance <= 50) {
                        setState(() {
                          _isTop = true;
                        });
                      }
                    }
                    return true;
                  },
                  child: ListView(
                    physics: _isTop == true
                        ? ClampingScrollPhysics()
                        : BouncingScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      Hero(
                        tag: _product.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.asset(
                            _product.image,
                            fit: BoxFit.cover,
                            height: 300,
                          ),
                        ),
                      ),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

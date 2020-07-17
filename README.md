# app store transition by flutter


### Use ``Hero`` and ``AnimatedBuilder`` 

I customize hero transition to fit App store transition as much as possible. 

**Demo**

![Hnet com-image](https://user-images.githubusercontent.com/18310281/87765427-607a8a00-c84a-11ea-9718-95883c853e02.gif)



## Key point




`lib/widgets/product_item.dart`
```
class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            /// Set [opaque] false, then the detail page can see the home page screen.
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
```


Use ``ScaleTransition`` and  ``onVerticalDragUpdate`` to control pop animation.




<img src="https://user-images.githubusercontent.com/18310281/87618224-ed8ae980-c74b-11ea-886c-19927612dab7.PNG" alt="" width="300" >



``lib/screen/product_detail_screen.dart``
```
/*
  .
  .
  .
  .
  .
*/
double _initPoint = 0;
double _pointerDistance = 0;
GestureDetector(
  onVerticalDragDown: (detail) {
    _initPoint = detail.globalPosition.dy;
  },
  onVerticalDragUpdate: (detail) {
    _pointerDistance = detail.globalPosition.dy - _initPoint;
    if (_pointerDistance >= 0 && _pointerDistance < 200) {
        // scroll up
        double _scaleValue = double.parse((_pointerDistance / 100).toStringAsFixed(2));
        if (_pointerDistance < 100) {
          _closeController.animateTo(_scaleValue,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear);
        }
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
  child: Hero(
    tag: _product.id,
    child: Image.asset(
      _product.image,
      fit: BoxFit.cover,
      height: 300,
    ),
  ),
),

```

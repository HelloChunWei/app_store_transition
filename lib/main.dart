import 'package:app_store_transition/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screen/home_screen.dart';
import './screen/open_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        // home: OpenContainerTransformDemo(),
      ),
    );
  }
}

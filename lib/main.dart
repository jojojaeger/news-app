import 'package:flutter/material.dart';
import 'package:news_app/HomeScreen.dart';
import './router.dart';

void main() => runApp(MyNewsApp());

class MyNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News App',
        theme: ThemeData(
          fontFamily: 'Baloo',
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: '/');
  }
}

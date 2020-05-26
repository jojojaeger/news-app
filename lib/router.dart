import 'package:flutter/material.dart';
import './HomeScreen.dart';
import './DetailScreen.dart';
import './SettingScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/details':
        var data = settings.arguments;
        return MaterialPageRoute(builder: (_) => DetailScreen(data));
      case '/settings':
        var selectedCountry = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => SettingScreen(selectedCountry));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: Text('Ooooops! Route not found.')));
    }
  }
}

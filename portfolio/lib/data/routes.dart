import 'package:flutter/material.dart';
import 'package:my_portfolio_web_app/modules/home/screens/home_screen.dart';

class Routes {
  static const home = '/home';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
  };
}

import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  bool get isLightTheme => Theme.of(this).brightness == Brightness.light;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}

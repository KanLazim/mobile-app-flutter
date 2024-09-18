import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

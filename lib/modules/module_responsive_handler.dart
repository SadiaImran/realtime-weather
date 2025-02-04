import 'package:flutter/material.dart';

class Responsive {
  static double baseWidth = 1920;
  static double baseHeight = 1080;

  static double width(BuildContext context, double w) {
    return MediaQuery.of(context).size.width * (w / baseWidth);
  }

  static double height(BuildContext context, double h) {
    return MediaQuery.of(context).size.height * (h / baseHeight);
  }

  static double avg(BuildContext context, double a) {
    return (width(context, a) + height(context, a)) / 2;
  }

  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}
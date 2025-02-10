import 'package:flutter/material.dart';
import '../screens/screen-home.dart';
import '../screens/screen-search.dart';
import '../screens/screen-splash.dart';

class AppRoutes {
  // Route map
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => ScreenSplash(),
    '/home': (context) => ScreenHome(),
    '/search' : (context) => ScreenSearch(),
  };
}

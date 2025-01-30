import 'package:flutter/material.dart';
import '../screens/screen_home.dart';
import '../screens/screen_search.dart';
import '../screens/screen_splash.dart';

class AppRoutes {
  // Route map
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => ScreenSplash(),
    '/home': (context) => ScreenHome(),
    '/search' : (context) => ScreenSearch(),
  };
}

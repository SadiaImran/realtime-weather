import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  static const List<Map<String, dynamic>> languages = [
    {'name': 'English', 'locale': 'en'},
    {'name': 'Spanish', 'locale': 'es'}
  ];

  Locale selectedLocale = const Locale('es');

  void changeLanguage(String language) {
    selectedLocale = Locale(language);
    notifyListeners();
  }
}
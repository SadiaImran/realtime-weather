import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const List<Map<String, dynamic>> languages = [
    {'name': 'English', 'locale': 'en'},
    {'name': 'Spanish', 'locale': 'es'}
  ];

  Locale selectedLocale = Locale('en');

  LanguageProvider() {
    _loadLanguage();
  }

  void changeLanguage(String language) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    selectedLocale = Locale(language);
    notifyListeners();
  }

  void _loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language');
    if (languageCode != null) {
      selectedLocale = Locale(languageCode);
    }
    notifyListeners();
  }
}

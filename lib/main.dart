import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/modules/translator/translator.dart';  
import './app/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create : (context) => LanguageProvider() ,
      child: const MyApp()));  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      supportedLocales: LanguageProvider.languages.map((e) => Locale(e['locale'])).toList(),
      locale: context.watch<LanguageProvider>().selectedLocale,
      localizationsDelegates: [
        AppLocalizations.delegate ,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash', 
      routes: AppRoutes.routes, 
      debugShowCheckedModeBanner: false, 
    );
  }
}


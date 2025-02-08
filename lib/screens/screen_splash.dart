import 'dart:async';
import 'package:flutter/material.dart';
import '../app/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.weatherApp,
          style: TextStyle(
            color: AppColors.lightGrey,
            fontFamily: 'Geometr415', 
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

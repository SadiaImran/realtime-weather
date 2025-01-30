import 'package:flutter/material.dart';
import '../app/colors.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 400,
              child: Image.asset(
                "assets/images/icon-weather.png",
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 45),
            Column(
              children: [
                const Text(
                  'Weather',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightBackground,
                  ),
                ),
                const Text(
                  'ForeCasts',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: AppColors.homeButtonTextBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.homeButtonTextBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 22),
              ),
              child: const Text('Get Started',
                  style: TextStyle(
                    fontFamily: 'SFUIDisplay',
                    fontSize: 18,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

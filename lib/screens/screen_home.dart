import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/modules/module_provider.dart';
import '../app/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 60), 
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
                    Text(
                      AppLocalizations.of(context)!.weather,
                      style: const TextStyle(
                        fontSize: 48,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.forecasts,
                      style: const TextStyle(
                        fontSize: 48,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: AppColors.homeButtonTextBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: 250, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.homeButtonTextBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.getStarted,
                      style: TextStyle(
                        fontFamily: 'SFUIDisplay',
                        fontSize: 18,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 15, 
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context)!.selectLanguage),
                        content: SizedBox(
                          width: double.maxFinite, 
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: LanguageProvider.languages.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  LanguageProvider.languages[index]['name']!,
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  final provider = context.read<LanguageProvider>();
                                  provider.changeLanguage(LanguageProvider.languages[index]['locale']);
                                  Navigator.pop(context); 
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.language,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

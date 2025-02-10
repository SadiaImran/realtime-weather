import 'package:flutter/material.dart';
import 'package:weather_app/app/colors.dart';
import '../modules/module_weather_model.dart';
import '../modules/module_weather_api.dart';
import 'package:intl/intl.dart';
import '../modules/responsive-handler/responsive-handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<StatefulWidget> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  ApiResponse? response;
  bool inProgress = false;
  List<String> imagePath = [
    "assets/images/icon-humidity.png",
    "assets/images/icon-wind.png"
  ];

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSearchWidget(),
                  const SizedBox(height: 50),
                  if (inProgress)
                    const CircularProgressIndicator()
                  else
                    _buildWeatherWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      hintText: AppLocalizations.of(context)!.searchAnyLocation,
      onSubmitted: (value) {
        _getWeatherData(value);
      },
    );
  }

  Widget _buildWeatherWidget(BuildContext context) {
    if (response == null) {
      return Text(AppLocalizations.of(context)!.searchForTheLocation);
    } else {
      double locationFontSize = Responsive.avg(context, 56);
      double countryFontSize = Responsive.avg(context, 48);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.darkText,
                size: 38,
              ),
              const SizedBox(width: 15),
              Text(
                response?.location?.name ?? "",
                style: TextStyle(
                  fontSize: locationFontSize,
                  fontWeight: FontWeight.w300,
                  color: AppColors.darkText,
                ),
              ),
              Text(
                " , ${response?.location?.country ?? ""}",
                style: TextStyle(
                  fontSize: countryFontSize,
                  fontWeight: FontWeight.w300,
                  color: AppColors.darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.darkText,
                ),
                child: Text(
                  formatLocalDate(response?.location?.localtime?.toString()),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${response?.current?.tempC.toString() ?? ""} °C",
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                    "https:${response?.current?.condition?.icon}"
                        .replaceAll("64x64", "128x128"),
                    scale: 0.7,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                translateWeatherCondition(response?.current?.condition?.text.toString() ?? "", context),
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Card(
            elevation: 6,
            color: AppColors.darkText,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget(
                        imagePath[0],
                        AppLocalizations.of(context)!.humidity,
                        response?.current?.humidity?.toString() ?? "",
                        context),
                    _dataAndTitleWidget(
                        imagePath[1],
                        AppLocalizations.of(context)!.windSpeed,
                        "${response?.current?.windKph?.toString() ?? ""} km/h",
                        context),
                    _dataAndTitleWidget(
                        imagePath[0],
                        AppLocalizations.of(context)!.preciptation,
                        "${response?.current?.precipMm?.toString() ?? ""} Mm",
                        context)
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _dataAndTitleWidget(
      String imgPath, String title, String data, BuildContext context) {
    double imageSize = Responsive.avg(context, 45); 
    double fontSize = Responsive.avg(context, 28);
    double titleFontSize = Responsive.avg(context, 18);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Image(image: AssetImage(imgPath) , width: imageSize, height: imageSize),
          const SizedBox(height: 10),
          Text(
            data,
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.secondaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.secondaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
            ),
          ),
        ],
      ),
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  String formatLocalDate(String? localtime) {
    if (localtime == null || localtime.isEmpty) return "N/A";

    try {
      DateTime parsedDate = DateTime.parse(localtime);
      String ans =
          "${response?.location?.localtime?.toString().split(" ").last ?? ""} , ${DateFormat("MMM d yyyy").format(parsedDate)}";
      return ans;
    } catch (e) {
      return "Invalid Date";
    }
  }

  String translateWeatherCondition(String condition, BuildContext context) {
  switch (condition.toLowerCase()) {
    case 'partly cloudy':
      return AppLocalizations.of(context)!.partlyCloudy;
    case 'overcast':
      return AppLocalizations.of(context)!.overcast;
    case 'rain':
      return AppLocalizations.of(context)!.rain;
    case 'moist':
      return AppLocalizations.of(context)!.moist;
    case 'light rain':
      return AppLocalizations.of(context)!.lightRain;
    case 'clear':
      return AppLocalizations.of(context)!.clear;
    case 'sunny':
      return AppLocalizations.of(context)!.sunny;
    case 'mist':
      return AppLocalizations.of(context)!.mist;
    case 'heavy rain':
      return AppLocalizations.of(context)!.heavyRain;
    case 'snow':
      return AppLocalizations.of(context)!.snow;
    case 'quite cloudy':
      return AppLocalizations.of(context)!.quiteCloudy;
    case 'fog':
      return AppLocalizations.of(context)!.fog;
    case 'thunderstorm':
      return AppLocalizations.of(context)!.thunderstorm;
    default:
      return condition;
  }
}
}
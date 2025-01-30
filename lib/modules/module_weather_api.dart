import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'package:weather_app/app/constants.dart';
import '../modules/module_weather_model.dart';

class WeatherApi {
  final String baseURL = "https://api.weatherapi.com/v1/current.json";

  Future<ApiResponse?> getCurrentWeather(String location) async {
    String apiUrl = "$baseURL?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      throw Exception("Failed to load weather: $e");
    }
  }
}

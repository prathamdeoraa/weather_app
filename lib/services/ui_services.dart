import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/screen_model.dart';

class WeatherServices {
  final String apiKey = "43ff547290494ab5844174949252110";
  final String baseUrl = "https://api.weatherapi.com/v1";

  Future<Weather> fetchWeather(String cityName) async {
    if (cityName.isEmpty) {
      throw Exception("City name cannot be empty");
    }

    try {
      final url = Uri.parse("$baseUrl/current.json?key=$apiKey&q=$cityName&aqi=no");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return Weather.fromJson(body);
      } else {
        throw Exception("Failed to fetch weather: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching weather data: $e");
    }
  }
}

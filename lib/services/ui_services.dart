import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/screen_model.dart';

class WeatherServices {
  final String apiKey = dotenv.env['API_KEY']!;
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<Weather> fetchWeather(String cityName) async {
    if (cityName.isEmpty) {
      throw Exception("City name cannot be empty");
    }

    try {
      final url = Uri.parse(
        "$baseUrl/current.json?key=$apiKey&q=$cityName&aqi=no",
      );
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

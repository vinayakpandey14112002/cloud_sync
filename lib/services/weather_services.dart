import 'package:cloudsync/modals/weather_modals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherServices {
  final String apiKey = 'ca7dba08ab11fa5af6b400ae249ecbed';

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey',
    );

    try {
      print('🔄 Fetching weather for: $cityName');
      print('🌐 Request URL: $url');

      final response = await http.get(url);

      print('📥 Response Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return Weather.fromJson(json.decode(response.body));
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Unknown error';
        throw Exception('API Error: $errorMessage');
      }
    } catch (e) {
      print('❌ Exception caught: $e');
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}

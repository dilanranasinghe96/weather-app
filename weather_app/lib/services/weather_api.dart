import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherAPI {
  final String _apiKey =
      'a2417be31b0961445dcfbbac499c0920'; // Replace with your actual API key
  final String _city =
      'Dambulla'; // Replace with the city you want weather information for

  Future<Map<String, dynamic>> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$_city&appid=$_apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> weatherData = json.decode(response.body);
      // Fetch hourly data
      final hourlyResponse = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$_city&appid=$_apiKey'));
      if (hourlyResponse.statusCode == 200) {
        final Map<String, dynamic> hourlyData =
            json.decode(hourlyResponse.body);
        weatherData['hourly'] = hourlyData['list'];
      } else {
        throw Exception('Failed to load hourly weather data');
      }
      return weatherData;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/custom%20widgets/background_theme.dart';
import 'package:weather_app/custom%20widgets/custom_text.dart';

class WeatherScreen2 extends StatefulWidget {
  final String location;
  const WeatherScreen2({Key? key, required this.location}) : super(key: key);

  @override
  _WeatherScreen2State createState() => _WeatherScreen2State();
}

class _WeatherScreen2State extends State<WeatherScreen2> {
  final String _apiKey =
      'a2417be31b0961445dcfbbac499c0920'; // Replace with your actual API key
  late final String _city =
      widget.location; // Replace with the city you want weather information for

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
        throw Exception(const Text(
          'Failed to load hourly weather data',
          style: TextStyle(decoration: TextDecoration.none),
        ));
      }
      return weatherData;
    } else {
      throw Exception(const Text('Failed to load weather data',
          style: TextStyle(decoration: TextDecoration.none)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundThme(
        size: size,
        child: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: fetchWeather(), // Fetch weather data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final weatherData = snapshot.data!;
                final cityName = weatherData['name'];
                final temp = (weatherData['main']['temp'] - 273.15)
                    .toDouble()
                    .toStringAsFixed(1);
                final weatherDescription =
                    weatherData['weather'][0]['description'];
                final tempMax = (weatherData['main']['temp_max'] - 273.15)
                    .toDouble()
                    .toStringAsFixed(1);
                final tempMin = (weatherData['main']['temp_min'] - 273.15)
                    .toDouble()
                    .toStringAsFixed(1);
                final humidity = weatherData['main']['humidity'];
                final windSpeed = weatherData['wind']['speed'];
                final weatherIcon = weatherData['weather'][0]['icon'];
                String iconUrl =
                    'http://openweathermap.org/img/wn/$weatherIcon@2x.png';

                // Extract hourly data
                final hourlyData = weatherData['hourly'];
                List<Map<String, dynamic>> hourlyWeatherList = [];

                for (var data in hourlyData) {
                  String time =
                      DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000)
                          .toString()
                          .substring(11,
                              16); // Extracting only the hour and minute part
                  String description = data['weather'][0]['description'];
                  final temp = (data['main']['temp'] - 273.15)
                      .toDouble()
                      .toStringAsFixed(1);
                  String icon = data['weather'][0]['icon'];
                  hourlyWeatherList.add({
                    'time': time,
                    'temperature': temp,
                    'icon': icon,
                    'description': description,
                  });
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                        ),
                        CustomPoppinsText(
                            text: cityName,
                            color: Colors.white,
                            fsize: 28,
                            fweight: FontWeight.w500),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(iconUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CustomPoppinsText(
                        text: weatherDescription,
                        color: Colors.white,
                        fsize: 25,
                        fweight: FontWeight.w500),
                    CustomPoppinsText(
                        text: '$temp°',
                        color: Colors.white,
                        fsize: 50,
                        fweight: FontWeight.w500),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(69, 104, 220, 0.5),
                          Color.fromRGBO(176, 106, 179, 0.5)
                        ]),
                        border: Border.all(color: Colors.white, width: 0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomPoppinsText(
                                    text: "Max: $tempMax° C",
                                    color: Colors.white,
                                    fsize: 18,
                                    fweight: FontWeight.w500),
                                SizedBox(height: size.height * 0.03),
                                CustomPoppinsText(
                                    text: "Wind: $windSpeed m/s",
                                    color: Colors.white,
                                    fsize: 18,
                                    fweight: FontWeight.w500),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.1),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomPoppinsText(
                                    text: "Min: $tempMin° C",
                                    color: Colors.white,
                                    fsize: 18,
                                    fweight: FontWeight.w500),
                                SizedBox(height: size.height * 0.03),
                                CustomPoppinsText(
                                    text: "Humidity: $humidity%",
                                    color: Colors.white,
                                    fsize: 18,
                                    fweight: FontWeight.w500),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      height: size.height * 0.2,
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(69, 104, 220, 0.5)),
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: 24, // Adjust itemCount to 24 for 24 hours
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // Calculate the hour dynamically
                            int hour = (DateTime.now().hour + index) % 24;
                            // Format hour to ensure it's displayed as 1, 2, 3, ..., 24
                            String hourLabel =
                                hour == 0 ? '24' : hour.toString();

                            final hourlyWeather = hourlyWeatherList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 10,
                                width: size.width * 0.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomPoppinsText(
                                      text:
                                          '$hourLabel:00', // Display hour label
                                      color: Colors.white,
                                      fsize: 14,
                                      fweight: FontWeight.w500,
                                    ),
                                    Image.network(
                                      'http://openweathermap.org/img/wn/${hourlyWeather['icon']}.png',
                                    ),
                                    CustomPoppinsText(
                                      text: '${hourlyWeather['temperature']}°C',
                                      color: Colors.white,
                                      fsize: 18,
                                      fweight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

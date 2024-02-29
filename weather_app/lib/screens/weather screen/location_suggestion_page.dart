import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/custom%20widgets/background_theme.dart';
import 'package:weather_app/custom%20widgets/custom_text.dart';
import 'package:weather_app/screens/weather%20screen/weather-screen2.dart';

class LocationSuggestionsPage extends StatefulWidget {
  const LocationSuggestionsPage({Key? key}) : super(key: key);

  @override
  _LocationSuggestionsPageState createState() =>
      _LocationSuggestionsPageState();
}

class _LocationSuggestionsPageState extends State<LocationSuggestionsPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    // Add listener to the TextEditingController
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // Delay clearing the suggestions list to allow time for rebuilding
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_controller.text.isEmpty) {
        setState(() {
          _suggestions.clear();
        });
      }
    });
  }

  void _fetchLocationSuggestions(String input) async {
    const apiKey = 'AIzaSyAT05ifN64edlWEZT2WBR3H8wZ5DPNHaUw';
    final inputEncoded = Uri.encodeQueryComponent(input);
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputEncoded&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _suggestions = List<String>.from(data['predictions'].map(
            (prediction) => prediction['structured_formatting']['main_text']));
      });
    } else {
      throw Exception('Failed to load location suggestions');
    }
  }

  Future<String> _getNearestCity() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      return placemarks.first.locality ?? "Unknown";
    } catch (e) {
      print('Error getting nearest city: $e');
      return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundThme(
        size: size,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                  ),
                  onPressed: () async {
                    String nearestCity = await _getNearestCity();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WeatherScreen2(location: nearestCity),
                      ),
                    );
                  },
                  child: CustomPoppinsText(
                    text: 'Current location',
                    color: Colors.black,
                    fsize: 18,
                    fweight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.75,
                child: Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomPoppinsText(
                        text: "OR",
                        color: Colors.white,
                        fsize: 16,
                        fweight: FontWeight.w500,
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.75,
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(69, 104, 220, 1),
                        Color.fromRGBO(176, 106, 179, 1)
                      ]),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(45))),
                  child: TextField(
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    controller: _controller,
                    onChanged: (value) {
                      _fetchLocationSuggestions(value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                      ),
                      hintText: 'Enter location',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WeatherScreen2(location: _suggestions[index]),
                          ),
                        );
                        _controller.clear();
                      },
                      child: ListTile(
                        title: Text(
                          _suggestions[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LocationSuggestionsPage(),
  ));
}

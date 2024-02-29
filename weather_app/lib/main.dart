import 'package:flutter/material.dart';
import 'package:weather_app/screens/splash%20screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

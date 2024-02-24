// import 'package:flutter/material.dart';
// import 'package:weather/weather.dart';
// import 'package:weather_app/custom%20widgets/background_theme.dart';
// import 'package:weather_app/custom%20widgets/custom_text.dart';

// class WeatherScreen1 extends StatefulWidget {
//   const WeatherScreen1({super.key});

//   @override
//   State<WeatherScreen1> createState() => _WeatherScreen1State();
// }

// class _WeatherScreen1State extends State<WeatherScreen1> {
//   final WeatherFactory _wf = WeatherFactory('a2417be31b0961445dcfbbac499c0920');

//   Weather? _weather;
//   @override
//   void initState() {
//     super.initState();
//     _wf.currentWeatherByCityName("Kurunegala").then((w) {
//       setState(() {
//         _weather = w;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 21, 47, 220),
//         title: CustomPoppinsText(
//             text: _weather?.areaName ?? "",
//             color: Colors.white,
//             fsize: 20,
//             fweight: FontWeight.w500),
//       ),
//       body: BackgroundThme(
//         size: size,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: size.height * 0.1,
//             ),
//             Image(
//               image: NetworkImage(
//                   "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
//               width: 150,
//               height: 150,
//             ),
//             SizedBox(
//               height: size.height * 0.05,
//             ),
//             CustomPoppinsText(
//                 text: _weather?.weatherDescription ?? "",
//                 color: Colors.white,
//                 fsize: 25,
//                 fweight: FontWeight.w500),
//             CustomPoppinsText(
//                 text:
//                     "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
//                 color: Colors.white,
//                 fsize: 50,
//                 fweight: FontWeight.w500),
//             SizedBox(
//               height: size.height * 0.05,
//             ),
//             Container(
//               width: size.width * 0.9,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 2),
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         CustomPoppinsText(
//                             text:
//                                 "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
//                             color: Colors.white,
//                             fsize: 20,
//                             fweight: FontWeight.w500),
//                         CustomPoppinsText(
//                             text:
//                                 "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
//                             color: Colors.white,
//                             fsize: 20,
//                             fweight: FontWeight.w500),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         CustomPoppinsText(
//                             text:
//                                 "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
//                             color: Colors.white,
//                             fsize: 20,
//                             fweight: FontWeight.w500),
//                         CustomPoppinsText(
//                             text:
//                                 "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
//                             color: Colors.white,
//                             fsize: 20,
//                             fweight: FontWeight.w500),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

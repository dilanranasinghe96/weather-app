import 'package:flutter/material.dart';
import 'package:weather_app/custom%20widgets/custom_button.dart';
import 'package:weather_app/custom%20widgets/custom_text.dart';

import '../../custom widgets/background_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackgroundThme(
      size: size,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Container(
            height: size.height * 0.3,
            width: size.height * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/weather.png'))),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          CustomPoppinsText(
              text: 'Weather',
              color: Colors.black,
              fsize: 40,
              fweight: FontWeight.bold),
          CustomPoppinsText(
              text: 'ForeCasts',
              color: Colors.black,
              fsize: 40,
              fweight: FontWeight.bold),
          SizedBox(
            height: size.height * 0.1,
          ),
          CustomButton(
              size: size,
              ontap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const HomePage(),
                //     ));
              },
              text: 'Get Started',
              buttonColor: Colors.amber,
              textColor: Colors.black)
        ],
      ),
    );
  }
}

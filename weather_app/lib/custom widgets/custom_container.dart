import 'package:flutter/material.dart';
import 'package:weather_app/custom%20widgets/custom_text.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.text,
      required this.ontap,
      required this.fsize});

  double width;
  double height;
  Color color;
  String text;
  VoidCallback ontap;
  double fsize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(10)),
            border: Border.all(width: 3, color: Colors.amber.shade700)),
        child: Center(
          child: CustomPoppinsText(
              text: text,
              color: Colors.black,
              fsize: fsize,
              fweight: FontWeight.w600),
        ),
      ),
    );
  }
}

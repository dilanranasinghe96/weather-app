import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.size,
      required this.ontap,
      required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.bHeight,
      required this.bWidth,
      required this.fSize});

  final Size size;
  VoidCallback ontap;
  Color buttonColor;
  Color textColor;
  String text;
  double bWidth;
  double bHeight;
  double fSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: bWidth,
        height: bHeight,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(buttonColor),
          ),
          onPressed: ontap,
          child: Center(
            child: CustomPoppinsText(
                color: textColor,
                fsize: fSize,
                fweight: FontWeight.bold,
                text: text),
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class BackgroundThme extends StatelessWidget {
  BackgroundThme({super.key, required this.size, required this.child});

  final Size size;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 5, 18, 106),
          Color.fromARGB(255, 78, 4, 91)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: child);
  }
}

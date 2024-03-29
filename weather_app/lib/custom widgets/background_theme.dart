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
          Color.fromRGBO(57, 95, 220, 1),
          Color.fromRGBO(181, 82, 184, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: child);
  }
}

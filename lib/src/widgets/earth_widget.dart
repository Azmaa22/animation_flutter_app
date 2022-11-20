import 'package:flutter/material.dart';
import 'dart:math' as math;

class Earth extends StatelessWidget {
  const Earth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 5),
      tween: Tween<double>(begin: 0.0, end: 2 * math.pi),
      builder: (BuildContext context, double angle, _) {
        return Transform.rotate(
          angle: angle,
          child: Image.asset(
            'assets/images/earth.jpeg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

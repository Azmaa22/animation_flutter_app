import 'package:animation_app/src/screens/aminations/basics_animation_screen.dart';
import 'package:animation_app/src/screens/home_screen.dart';
import 'package:animation_app/src/screens/islamic_rosary.dart';
import 'package:animation_app/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasicAnimation(),
    );
  }
}

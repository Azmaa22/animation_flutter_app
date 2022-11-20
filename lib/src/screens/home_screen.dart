import 'package:animation_app/src/widgets/ball_widget.dart';
import 'package:animation_app/src/widgets/earth_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Earth Soccer Player',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: const [
          Positioned(left: 0, right: 0, bottom: 250, child: Ball()),
          Positioned(
            left: 0,
            right: 0,
            bottom: -250,
            child: Earth(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class IslamicRosary extends StatefulWidget {
  const IslamicRosary({Key? key}) : super(key: key);

  @override
  State<IslamicRosary> createState() => _IslamicRosaryState();
}

class _IslamicRosaryState extends State<IslamicRosary> {
  double turns = 0.0;

  void _changeRotation() {
    setState(() => turns += 1.0 / 8.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Animated Islamic Rosary'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(seconds: 1),
                  alignment: Alignment.center,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/rosary_frame.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 180,
                  child: Center(
                    child: Text(turns.toString()),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _changeRotation,
            child: const Text('Rotate Logo'),
          ),
        ],
      ),
    );
  }
}

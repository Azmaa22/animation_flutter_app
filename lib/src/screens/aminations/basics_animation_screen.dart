import 'package:flutter/material.dart';

class BasicAnimation extends StatefulWidget {
  const BasicAnimation({Key? key}) : super(key: key);

  @override
  State<BasicAnimation> createState() => _BasicAnimationState();
}

// step #1
class _BasicAnimationState extends State<BasicAnimation>
    with SingleTickerProviderStateMixin {
  // step #2
  late AnimationController controller;
  // step #3
  late Tween<Alignment> tween;
  // step #4
  final Curve curve = Curves.ease;
  // step #5
  late Animation<Alignment> animation;
  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(
        seconds: 3,
      ),
      vsync: this,
    ); // <<< 2. Pass this class to AnimationController
    tween = Tween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ); // <<< 3. Decide animate what value and it's start and end values.
    tween.chain(
      CurveTween(
        curve: curve,
      ),
    ); // <<< 4. Apply curve effect to Tween
    animation = controller
        .drive(tween); // <<< 5. Create Animation by AnimationController x Tween

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter app'),
      ),
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Align(
            alignment: animation.value, // <<< 6. Apply Animation to Widget
            child: Text('Hello world!'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (animation.value == Alignment.topCenter) {
            controller.forward(); // <<< 7. Start Animating by forward!!
          } else {
            controller.reverse();
          }
        },
        backgroundColor: Colors.yellow[700],
        child: const Icon(
          Icons.bolt,
          color: Colors.black,
        ),
      ),
    );
  }
}

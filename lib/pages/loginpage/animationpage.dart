// animation.dart

import 'package:flutter/material.dart';

class _ScaleAnimation extends StatefulWidget {
  const _ScaleAnimation({Key? key}) : super(key: key);

  @override
  State<_ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<_ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> animation =
        Tween(begin: 4.5, end: 2.2).animate(_animationController);

    return ScaleTransition(
      scale: animation,
      child: SizedBox(
        width: 10000,
        height: 10000,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -70,
              left: 2,
              child: Container(
                width: 500,
                height: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blueround.png'),
                      opacity: 0.8),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 150,
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blueround.png'),
                      opacity: 0.5),
                ),
              ),
            ),
            Positioned(
              top: 400,
              left: -90,
              child: Container(
                width: 550,
                height: 550,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blueround.png'),
                      opacity: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingAnimationPage extends StatefulWidget {
  const LandingAnimationPage({super.key});

  @override
  State<LandingAnimationPage> createState() => _LandingAnimationPageState();
}

class _LandingAnimationPageState extends State<LandingAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "URBAN LINK",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
        ),
        const _ScaleAnimation(),
      ],
    );
  }
}

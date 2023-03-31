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
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 0.8 * MediaQuery.of(context).size.width,
                height: 0.8 * MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blueround.png'),
                      opacity: 0.8),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.2,
              left: MediaQuery.of(context).size.width * 0.2,
              child: Container(
                width: 0.7 * MediaQuery.of(context).size.width,
                height: 0.7 * MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blueround.png'),
                      opacity: 0.5),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.9,
              left: MediaQuery.of(context).size.width * 0.2,
              child: Container(
                width: 0.7 * MediaQuery.of(context).size.width,
                height: 0.7 * MediaQuery.of(context).size.width,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: const [
                _ScaleAnimation(),
                Text(
                  "URBAN LINK",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

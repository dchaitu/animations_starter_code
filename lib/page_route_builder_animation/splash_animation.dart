import 'dart:async';

import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 1000));
  scaleAnimation = Tween<double>(begin: 1, end: 12).animate(animationController);
  animationController.addListener(() {
    if(animationController.isCompleted) {
        Navigator.of(context).push(
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 10000),
            reverseTransitionDuration: const Duration(milliseconds: 10000),
            pageBuilder: (context, animation, secondaryAnimation) {
              return const Destination();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final positionTween =
                  Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                      .animate(animation);
              return SlideTransition(
                position: positionTween,
                child: child,
              );
            },
          ),
        );
        Timer(const Duration(milliseconds: 1000), () {
          animationController.reset();
        });
      }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            animationController.forward();

          },
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
    );
  }
}

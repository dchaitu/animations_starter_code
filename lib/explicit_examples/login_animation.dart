import 'package:flutter/material.dart';

class LoginScreenAnimation extends StatefulWidget {
  const LoginScreenAnimation({super.key});

  @override
  State<LoginScreenAnimation> createState() => _LoginScreenAnimationState();
}

class _LoginScreenAnimationState extends State<LoginScreenAnimation> with SingleTickerProviderStateMixin {
  late Animation<double> animateOpacity;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,
    duration: Duration(milliseconds: 1500));
    animateOpacity = Tween<double>(begin: 0.0,end: 1.0).animate(animationController);
    slideAnimation = Tween<Offset>(begin: Offset(-1.0, 1.0),
        end: Offset(0.0, 1.0)).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));

    scaleAnimation = Tween<double>(begin: 0.5,end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease)
    );

    animateOpacity.addListener(() {
      if(animateOpacity.isCompleted)
        animationController.reverse();
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: animateOpacity,
              child: const FlutterLogo(
                size: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

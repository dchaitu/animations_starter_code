import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation centerAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    centerAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();

    animationController.addStatusListener((status) {
      if(status ==AnimationStatus.completed)
        {
          animationController.reverse();
        }
      else if(status == AnimationStatus.dismissed){
        animationController.forward();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: centerAnimation,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  size: const Size(200, 200),
                  painter: BouncingBallPainter(centerAnimation.value),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class BouncingBallPainter extends CustomPainter {
  final double animationValue;

  BouncingBallPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(size.width / 2, size.height * (1 - animationValue)),
        33,
        Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

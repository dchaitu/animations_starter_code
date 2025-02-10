import 'package:flutter/material.dart';

class RadialProgressAnimation extends StatefulWidget {
  final double progress;
  final Color color;

  const RadialProgressAnimation({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  State<RadialProgressAnimation> createState() => _RadialProgressAnimationState();
}

class _RadialProgressAnimationState extends State<RadialProgressAnimation> with SingleTickerProviderStateMixin{


  late AnimationController animationController;
  late Animation animationProgress;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    animationProgress = Tween<double>(begin: 0 , end: widget.progress).animate(animationController);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationProgress,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: animationProgress.value,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade100,
                    color: widget.color,
                  ),
                ),
                Text(
                  '${(animationProgress.value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(animationController.isCompleted) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}

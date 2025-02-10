import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation> with SingleTickerProviderStateMixin {
  int listItemsCount = 5;
  late AnimationController animationController;

  late List<Animation<Offset>> tilesSlideAnimation = [];

  @override
  void initState() {

    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    // tilesSlideAnimation = Tween<Offset>(begin: Offset(-1, 1), end: Offset(0, 1)).animate(animationController);

    // animationController.forward();
    tilesSlideAnimation = List.generate(listItemsCount,
            (index) => Tween<Offset>(begin: Offset(-1, 1), end: Offset(0, 1)).
            animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval((index/listItemsCount).toDouble(), 1.0)),
            ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: listItemsCount,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: tilesSlideAnimation[index],
            child: ListTile(
              title: Text('Hello World, Rivaan. ${index.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(animationController.isCompleted) {
            animationController.reverse();
          }
          else {
            animationController.forward();
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}

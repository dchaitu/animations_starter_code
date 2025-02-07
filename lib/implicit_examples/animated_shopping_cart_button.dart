import 'package:flutter/material.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({super.key});

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  Color selectedColor = Colors.green;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isExpanded =!isExpanded;
            });
          },
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: isExpanded? 180.0: 80,
            height: 60.0,
            decoration: BoxDecoration(
              color: isExpanded? selectedColor:Colors.blue,
              borderRadius: BorderRadius.circular(isExpanded?30:10.0),
            ),
            duration: Duration(milliseconds: 500),
            child:  Row(
              children: [
                Align(
                  alignment: isExpanded?Alignment.centerLeft: Alignment.center,
                  child: Icon(
                    isExpanded?Icons.check:Icons.shopping_cart,
                      color: Colors.white,
                    ),
                ),
                isExpanded?Expanded(child: Text("Added to cart",style: TextStyle(color: Colors.white),)):Expanded(child: SizedBox())
              ],
            ),
            ),
        ),
        ),
    );
  }
}

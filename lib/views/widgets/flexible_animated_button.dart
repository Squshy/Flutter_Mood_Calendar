// Flexible widget that displays a button that has a function and text
import 'package:flutter/material.dart';

class FlexibleAnimatedButton extends StatelessWidget {
  final String text;  // Text for the button
  final bool canPress; // Check if the function can be called
  final Function func;  // Function to be called on press
  final int flex; // The flex level for the widget
  final double fontSize;
  final Color activatedColor;

  FlexibleAnimatedButton({
    Key key, 
    @required this.text, 
    @required this.canPress, 
    @required this.func,
    @required this.flex,
    @required this.fontSize,
    @required this.activatedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: this.flex,
      child: GestureDetector(
        onTap: () => canPress ? this.func() : null,  // If you allow the function to be called, do its
        child: AnimatedContainer(
          color: canPress ? activatedColor : Theme.of(context).primaryColor,
          duration: Duration(milliseconds: 75), // Allows the colors to ease in and out
          child: Center(
            child: Text(
              text,
              style: TextStyle(  
                fontSize: this.fontSize,
              ),
            ),  // Text of the button
          ),
        ),
      ),
    );
  }
}
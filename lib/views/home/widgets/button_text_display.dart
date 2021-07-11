// Displays a text and button that sends a user to a new page
import 'package:flutter/material.dart';
import 'package:mood/views/widgets/flexible_animated_button.dart';

class ButtonAndTextDisplay extends StatelessWidget {
  final String text;  // text to be displayed
  final String buttonText;  // Button's text
  final String route; // Route to travel to
  final Color buttonColor;  // Color of button
  final Color backgroundColor;
  ButtonAndTextDisplay(this.text, this.buttonText, this.route, this.buttonColor, this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(  
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2
          )
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Text(
              text,
              style: TextStyle(  
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: Theme.of(context).textTheme.headline1.color
              ),
              textAlign: TextAlign.left,
            ),
          ),
          FlexibleAnimatedButton(
            text: buttonText,
            canPress: true,
            func: () => Navigator.pushNamed(context, route),
            flex: 1,
            fontSize: 20,
            activatedColor: buttonColor,// Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
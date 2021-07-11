// Loading screen display for app
import 'dart:async';
import 'package:flutter/material.dart';

class TransitionScreen extends StatefulWidget {
  final bool _isLoggedIn; // If the user is logged in
  final bool _moveToNextPage; // If we are passed checks to move to next page
  final String _text; // The text to be displayed
  TransitionScreen(this._text, this._isLoggedIn, this._moveToNextPage);

  @override
  _TransitionScreenState createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorTween;
  
  @override
  void initState() {
    super.initState();
    // Variable inits
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _colorTween = _animationController.drive(
      ColorTween(
        begin: Colors.green,
        end: Colors.red
      ));
    _animationController.repeat();
    // Checks every 3 seconds if we are good to move to next page
    Timer.periodic(
      Duration(seconds: 2),
      (t) { 
        if(widget._moveToNextPage && widget._isLoggedIn != null)  // If we are able to move to next page
          WidgetsBinding.instance
              .addPostFrameCallback((_) {
                if(widget._isLoggedIn) {  // If we are logged in then move to home
                  t.cancel(); // stop time
                  Navigator.pushReplacementNamed(context, "/home");
                } else {
                  t.cancel(); // stop timer
                  Navigator.pushReplacementNamed(context, "/login");
                }
              }); // Used to navigate after the widget has been built | stops problem navigating before widget is built
      }
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Kill the animation controller🔪
    super.dispose();
  }

  // Returns a material widget
  // Displays title of app and an animated circularprogress indicator
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget._text,
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).textTheme.headline1.color
              ),
            ),
            CircularProgressIndicator(
              valueColor: _colorTween,
              backgroundColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ),
    );
  }
}
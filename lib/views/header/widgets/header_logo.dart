import 'package:flutter/material.dart';
import '../../../utility.dart';
// Builds the main logo area for the header
// Contains an Icon within a circular avatar 

class HeaderLogo extends StatefulWidget {
  final IconData icon;
  HeaderLogo({Key key, this.icon}) : super(key: key);

  @override
  _HeaderLogoState createState() => _HeaderLogoState();
}

class _HeaderLogoState extends State<HeaderLogo> with SingleTickerProviderStateMixin {
  

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override 
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector( 
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/home');
          }, 
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Utility.background.evaluate(AlwaysStoppedAnimation(_animationController.value)),
            child: CircleAvatar( 
              radius: 35,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                widget.icon,
                color: Utility.background.evaluate(AlwaysStoppedAnimation(_animationController.value)),
                size: 55,
              )
            )
          )
        );
      }
    );
  }
}
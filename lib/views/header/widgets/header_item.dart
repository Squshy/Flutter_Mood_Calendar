import 'package:flutter/material.dart';
// The left-most item of header
// Displays hamburger icon or back arrow icon depending on if you are at home page or not

class HeaderItem extends StatelessWidget {
  final bool isHome;

  const HeaderItem({Key key, @required this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: () {
        // If it is home node then open drawer else pop up navigation tree
        this.isHome ? Scaffold.of(context).openDrawer() : Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(  
          color: Colors.white.withAlpha(5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          this.isHome ? Icons.menu : Icons.arrow_back,  // if this is home screen show hamburger else back arrow
          color: Colors.white.withAlpha(80),
          size: 30,
        )
      )
    );
  }
}
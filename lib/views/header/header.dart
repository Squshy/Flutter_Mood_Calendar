// Header Container
// Displays the header with positioned children in a stack
// Used for naviation purposes
import 'package:flutter/material.dart';
import 'package:mood/views/header/widgets/header_clipper.dart';

import './widgets/header_logo.dart';
import './widgets/header_item.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  Header({Key key, @required this.isHome}) : super(key: key);

  final bool isHome;

  @override 
  _HeaderState createState() => _HeaderState();
  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material( 
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: ClipPath(  // this is the rectangluar + circular shape of the header using clippath
                clipper: HeaderClipper(), // set of lines and paths to create shape
                child: Container( // Container for the clip path 
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                  ),
                )
              ),
            ),
            Positioned(  // Contains the logo/main focus of the nav
              bottom: 15,
              width: MediaQuery.of(context).size.width,
              child: Row(  
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HeaderLogo(icon: Icons.tag_faces)
                ]
              ),
            ),
            Positioned(  // Contains the hamburger icon/back icon
              bottom: 45,
              left: 15,
              width: MediaQuery.of(context).size.width,
              child: Row(  
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  HeaderItem(
                    isHome: widget.isHome
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
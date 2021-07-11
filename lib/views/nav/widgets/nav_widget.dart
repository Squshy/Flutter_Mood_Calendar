// The widget for a nav item to be displayed in the nav
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class NavWidget extends StatelessWidget {
  final String title; // Title of item
  final IconData icon;  // Icon to be displayed
  final Color color;  // Color of the icon
  final Function func;  // Function of the nav item
  NavWidget(this.title, this.icon, this.color, this.func);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => func(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          decoration: BoxDecoration(  
            boxShadow: [  // Display an inwards box shadow
              BoxShadow(
                color: Colors.grey[800]
              ),
              BoxShadow(  
                color: Theme.of(context).primaryColor,
                spreadRadius: -0.3,
                blurRadius: 3,
              )
            ],
            border: Border(
              right: BorderSide(
                width: 1,
                color: Colors.grey[700]
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                FlutterI18n.translate(context, title),  // Translate the title
                style: TextStyle(  
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
              Icon(
                icon,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
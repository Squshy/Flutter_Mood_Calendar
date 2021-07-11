// A widget displayed if the firebase db fails to load
import 'package:flutter/material.dart';

class DBLoadFailure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Text(
            "Could not initialize a database connection.\nPlease try again later.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
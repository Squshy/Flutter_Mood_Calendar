import 'package:flutter/material.dart';

// Build and shows the snackbar
void showSnackBar(BuildContext context, String message, Color color,
    GlobalKey<ScaffoldState> key) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 2),
    backgroundColor: color,
    content: Text(message),
  );
  key.currentState.showSnackBar(snackBar);
}

// This one is used when sending a snackbar back through Navigation.pop()
SnackBar showSnackBarPersist(
    BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 2),
    backgroundColor: color,
    content: Text(message),
  );
  return snackBar;
}

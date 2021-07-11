// Custom theme for application
// Custom colors are stored here
import 'package:flutter/material.dart';

final ThemeData customTheme = _buildCustomTheme();

ThemeData _buildCustomTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: Color.fromARGB(255, 46, 46, 46),
    scaffoldBackgroundColor: Color.fromARGB(255, 32, 32, 32),
    backgroundColor: Color.fromARGB(255, 32, 32, 32),
    buttonColor: Colors.green,
    errorColor: Colors.red,
    accentIconTheme: IconThemeData(
      color: Colors.grey
    ),
    accentTextTheme: TextTheme(  
      headline6: TextStyle(  
        color: Colors.grey,
      )
    ),
    textTheme: TextTheme(  
      headline1: TextStyle(  
        color: Colors.grey,
      ),  
      headline2: TextStyle(  
        color: Colors.grey,
      ),  
      headline3: TextStyle(  
        color: Colors.grey,
      ),  
      headline4: TextStyle(  
        color: Colors.grey,
      ),  
      headline5: TextStyle(  
        color: Colors.grey,
      ),  
      headline6: TextStyle(  
        color: Colors.grey,
      ),
      subtitle1: TextStyle(  
        color: Colors.white
      ),
    ),
  );
}
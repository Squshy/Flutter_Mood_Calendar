// Widget to display the current and selected locale
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
// Utils
import '../../../../utility.dart';

class CurrentLocaleDisplay extends StatelessWidget {
  final String selectedLanguage;  // The current selected language
  CurrentLocaleDisplay({Key key, @required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(  
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Split into two seperate Text widgets because some language texts are larger than others
                // This combats the jumping of text if you concatenate the strings
                Text(
                  FlutterI18n.translate(context, "settings.language_settings.selected"),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  this.selectedLanguage == null ? "None" : this.selectedLanguage, // If no language is selected display none, else: display the language
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ]
            ),
          ),
          Center(
            child: Container(  
              child: Text(
                _getCurrentLocaleString(context), // String of current locale
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

  // Returns a string showing the current locale
  String _getCurrentLocaleString(BuildContext context) {
    return FlutterI18n.translate(
      context, 
      "settings.language_settings.current_locale",
      translationParams: {"locale": Utility.beautifyLocaleString(FlutterI18n.currentLocale(context).toString())}
      );
  }
}
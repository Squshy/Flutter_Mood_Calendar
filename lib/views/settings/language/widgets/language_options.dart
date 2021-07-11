// Displays a list view of the language options offered in the app
import 'package:flutter/material.dart';
// widgets
import './language_option.dart';
// constants 
import '../../../../constants/languages.dart';

class LanguageOptions extends StatelessWidget {
  final Function selectLocale;  // Function for selecting a language
  LanguageOptions({Key key, @required this.selectLocale});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: _buildLanguageOptions(),
    );
  }

  // Builds a list of flexible widgets to be displayed
  // Builds x amount according to the available languages
  // Each widget has a function for saving the language
  List<Flexible> _buildLanguageOptions() {
    List<Flexible> languageOptions = [];
    for(int i = 0; i < availableLanguages.length; i++) {
      languageOptions.add(
        Flexible(  
          flex: 2,
          child: LanguageOption(
            language: availableLanguages[i], 
            index: i,
            selectLocale: this.selectLocale,
          )
        ));
    }
    return languageOptions;
  }
}
// Widget for displaying an individual language option
import 'package:flutter/material.dart';
import '../../../../constants/languages.dart';

class LanguageOption extends StatelessWidget {
  final Language language;  // Langauge object of the widget
  final int index;  // Index of the language in the language list
                    // Used for border styling (if its last object, first)
  final Function selectLocale;  // Function for on press of widget

  LanguageOption({
    Key key, 
    @required this.language, 
    @required this.index,
    @required this.selectLocale
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectLocale(this.language), // Select the displayed language
      child: Container(
        padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(  
                    color: Theme.of(context).primaryColor,
                    width: index == 0 ? 1 : 0.5 // If it's the first object, display a thicker top border
                  ),
                  left: BorderSide(  
                    color: Theme.of(context).primaryColor,
                    width: 0.5
                  ),
                  right: BorderSide(  
                    color: Theme.of(context).primaryColor,
                    width: 0.5
                  ),
                  bottom: BorderSide(  
                    color: Theme.of(context).primaryColor,
                    width: index == (availableLanguages.length - 1) ? 1 : 0.5 // If it's last object display a thicker bottom border
                  ),
                ),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(  
              child: Text(this.language.name) // Name of the language
            ),
          ]
        ),
      ),
    );
  }
}
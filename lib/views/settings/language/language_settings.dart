// Class for handling Language Setting functionality
// Displays a list of of language options available to select from
// If the newly selected language is different than that already being used you can save your changes
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

// widgets
import './widgets/current_locale_display.dart';
import './widgets/language_options.dart';
import 'package:mood/views/widgets/flexible_animated_button.dart';

// constants
import '../../../constants/languages.dart';

class LanguageSettings extends StatefulWidget {
  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  Language _selectedLanguage = Language(name: null, localeKey: null); // Used to check which language has been selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "settings.language_settings.title")),
        shadowColor: Colors.transparent,
      ),
      body: Flex(  
        direction: Axis.vertical,
        children: [
            Flexible(
              flex: 1,
              child: CurrentLocaleDisplay(selectedLanguage: _selectedLanguage.name) // Top widget showing current locale and selected locale
            ),
            Flexible(  
              flex: 9,
              child: LanguageOptions(selectLocale: _updateSelectedLocale),  // Displays all language options with a function to update the currently selected language
            ),
            FlexibleAnimatedButton(
              text: "Save",
              canPress: _readyToSaveLocale(),
              func: _saveNewLocale,
              flex: 1,
              fontSize: 14,
              activatedColor: Theme.of(context).buttonColor,
            ), 
          ],
      ),
    );
  }

  // Updates the selected language
  void _updateSelectedLocale(Language language) {
    setState(() => _selectedLanguage = language);
  }

  // Checks if the settings are ready to be saved
  bool _readyToSaveLocale() {
    if(_selectedLanguage.localeKey == null) // If there is a setting selected
      return false;
    else if(_selectedLanguage.localeKey == FlutterI18n.currentLocale(context).toString()) // If the language is different than the current language
      return false;
    else return true;
  }

  // Function to set the locale to the newly selected language
  void _saveNewLocale() async {
    FlutterI18n.refresh(
      context, 
      new Locale(_selectedLanguage.localeKey)
    ).then((_) => Navigator.pop(context));
  }
}
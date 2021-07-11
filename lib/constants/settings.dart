import 'package:flutter/material.dart';

// Setting class to hold data for a setting
class Setting {
  String translationKey;
  IconData icon;
  String route; 
  Setting({this.translationKey, this.icon, this.route});
}

// List of settings with a name, icon, and route to go to
List<Setting> settings = [
  Setting(
    translationKey: "settings.color_settings.title", 
    icon: Icons.color_lens, 
    route: "/colorSettings"
  ),
  Setting(
    translationKey: "settings.language_settings.title", 
    icon: Icons.translate, 
    route: "/languageSettings"
  ),
  Setting(
    translationKey: "settings.password_settings.title", 
    icon: Icons.change_history, 
    route: "/changePassword"
  ),
];
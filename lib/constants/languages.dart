// File to hold available languages offered in the app
import 'package:flutter/material.dart';

class Language {
  String name;
  String localeKey;
  Language({@required this.name, @required this.localeKey});
}

List<Language> availableLanguages = [
  Language(name: "English", localeKey: "en_US"),
  Language(name: "힌국어", localeKey: "kr"),
];
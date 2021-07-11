// File for storing info for selectable moods
// This is used for seeing what moods are selectable
// usefull to isolate it so it can be used in multiple places
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoodIcons {
  int moodValue;
  String name;
  FaIcon iconName;
  MoodIcons(this.moodValue, this.name, this.iconName);
}

final List<MoodIcons> moodList = [
  MoodIcons(5, "Ecstatic", FaIcon(FontAwesomeIcons.laugh)),
  MoodIcons(4, "Happy", FaIcon(FontAwesomeIcons.smile)),
  MoodIcons(3, "Neutral", FaIcon(FontAwesomeIcons.meh)),
  MoodIcons(2, "Sad", FaIcon(FontAwesomeIcons.frown)),
  MoodIcons(1, "Depressed", FaIcon(FontAwesomeIcons.sadCry)),
  MoodIcons(6, "Angry", FaIcon(FontAwesomeIcons.angry)),
];
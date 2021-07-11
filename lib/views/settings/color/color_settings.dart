// Color settings 
// This page will allow a user to change their color preferences within the app
// These color preferences refer to the colors for the specified moods, maybe users are happy with red
// Uses the Flutter Material Picker plugin
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:provider/provider.dart';

// static data
import '../../../constants/selectable_moods.dart';

// db
import '../../../model/database/users/users_model.dart';

// store
import '../../../model/store/user.dart';
// Utility
import '../../../utility.dart';

// widgets 
import './widgets/mood_option.dart';
import '../../widgets/flexible_animated_button.dart';

class ColorSettings extends StatefulWidget {
  @override
  _ColorSettingsState createState() => _ColorSettingsState();
}

class _ColorSettingsState extends State<ColorSettings> {
  Color _color1, _color2, _color3, _color4, _color5, _color6; // selected color
  UserBLoC userBLoC;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setColorsToBLoC();
    });
  }

  @override
  Widget build(BuildContext context) {
    userBLoC = context.watch<UserBLoC>(); // BLoC watching widget tree

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "settings.color_settings.title")),
        shadowColor: Colors.transparent,
      ),
      body: Flex(  
        direction: Axis.vertical,
        children: buildFlexOptions(), // The list of widgets from the function
                                      // Returns all mood options and also a save button
      ),
    );
  }

  // Sets the colors in state to the colors saved in BLoC state
  void setColorsToBLoC() {
    setState(() {
      _color1 = userBLoC.colorOne;
      _color2 = userBLoC.colorTwo;
      _color3 = userBLoC.colorThree;
      _color4 = userBLoC.colorFour;
      _color5 = userBLoC.colorFive;
      _color6 = userBLoC.colorSix;
    });
  }

  // Displays a mood option for the specific item in the list
  Widget displayMoodOption(MoodIcons mood, int index) {
    Color color;
    switch (mood.moodValue) {
      case 1:
        color = _color1;
        break;
      case 2:
        color = _color2;
        break;
      case 3:
        color = _color3;
        break;
      case 4:
        color = _color4;
        break;
      case 5:
        color = _color5;
        break;
      case 6:
        color = _color6;
        break;
    }
    return MoodOption(
      mood: mood, 
      color: color, 
      ind: index, 
      selectColor: _selectColor,
    );
  }

  // Adds each MoodOption widget into a list of widgets to be displayed
  List<Widget> buildFlexOptions() {
    List<Widget> flexItems = [];
    for (int i = 0; i < moodList.length; i++) {
      flexItems.add(displayMoodOption(moodList[i], i));
    }
    flexItems.add(FlexibleAnimatedButton( // Button for saving if there are changes detected
      canPress: _didUserMakeChange(), 
      text: "Save", 
      flex: 2, 
      func: () => Utility.saveConfirmationDialog(
        context, 
        _saveColors, 
        "Save Changes",
        "No", 
        "Do you want to save your changes?", 
        "Yes"
      ),
      fontSize: 20,
      activatedColor: Theme.of(context).buttonColor,
    ));  // Add a save button as the last item
    return flexItems;
  }

  bool _didUserMakeChange() {
    if(_color1 != userBLoC.colorOne)
      return true;
    else if(_color2 != userBLoC.colorTwo)
      return true;
    else if(_color3 != userBLoC.colorThree)
      return true;
    else if(_color4 != userBLoC.colorFour)
      return true;
    else if(_color5 != userBLoC.colorFive)
      return true;
    else if(_color6 != userBLoC.colorSix)
      return true;
    else 
      return false;
  }

  // Function for selecting a color
  // Displays a Palette Picker
  void _selectColor(MoodIcons mood, Color color) {
    showMaterialPalettePicker(
      context: context,
      selectedColor: color,
      onChanged: (value) => _setMoodColors(mood, value),
    );
  }

  // Depending on which mood was altered, update the state to the new color
  void _setMoodColors(MoodIcons mood, Color color) {
    switch (mood.moodValue) {
      case 1:
        setState(() {_color1 = color;});
        break;
      case 2:
        setState(() {_color2 = color;});
        break;
      case 3:
        setState(() {_color3 = color;});
        break;
      case 4:
        setState(() {_color4 = color;});
        break;
      case 5:
        setState(() {_color5 = color;});
        break;
      case 6:
        setState(() {_color6 = color;});
        break;
      default:
    }
  }

  // When called, will update database to new colors saved in state
  // Updates BLoC to use new colors as well
  // Returns user from color options to general settings page
  void _saveColors() {
    UsersModel userModel = UsersModel();
    userBLoC.setAllMoodColors(_color1, _color2, _color3, _color4, _color5, _color6);
    print("User: " + userBLoC.user.toString());
    userModel.updateUsers(userBLoC.user);
    Navigator.of(context).pop();
  }
}
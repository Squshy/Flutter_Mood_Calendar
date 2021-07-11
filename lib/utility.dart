import 'package:flutter/material.dart';
import 'package:mood/model/database/mood/mood_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'constants/selectable_moods.dart';
import 'model/database/mood/mood.dart';
import 'model/store/user.dart';
// import local database classes needed
import './model/database/users/users.dart';
import './model/database/users/users_model.dart';

class Utility {

  //list of colours to display flowing
  static Animatable<Color> background = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.blue[900],
          end: Colors.blue,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.blue,
          end: Colors.lightGreen[700],
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.lightGreen[700],
          end: Colors.lightGreen[800],
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.lightGreen[800],
          end: Colors.green[700],
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.green[700],
          end: Colors.red[900],
        ),
      ),
      TweenSequenceItem(
        weight: 2.0,
        tween: ColorTween(
          begin: Colors.red[900],
          end: Colors.blue[900],
        ),
      ),
    ],
  );

  //add flags into shared preferences for easy access and user not having to repeatedly login
  static createPersistentData(UsersModel model, Users user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("userID", user.id);
    prefs.setBool("isLoggedIn", true);
    print(prefs.getBool("isLoggedIn"));
  }

  //sets the shared preferences flag for log out so the user stays logged out of the app
  static logMeOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("isLoggedIn", false);
  } 

  // displays the error dialog with unique error
  static void showError(BuildContext context, String error){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: [
            FlatButton(
              color: Theme.of(context).errorColor,
              child: Text('Exit'),
              onPressed: () => Navigator.pop(context),
              )
          ],
      );
      }
    );
  }

  // Formats a string of locale into uppercase and replaces all '_' with ' ' 
  static String beautifyLocaleString(String locale) {
    return locale.replaceAll(RegExp('_'), " ").toUpperCase();
  }

  // Displays a dialog box
  // Allows for custom title and button texts as well as a custom function for on accept
  static Future<void> saveConfirmationDialog(BuildContext context, Function onAccept, String titleText, String denyButtonText, String subtitleText, String acceptButtonText) async {
    return showDialog<void> (
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Text(subtitleText, style: TextStyle(color: Colors.white)),
          title: Text(
            titleText,
            style: TextStyle(  
              color: Colors.white
            )
          ),
          actions: [
            FlatButton(
                  child: Text(acceptButtonText, style:TextStyle(color: Theme.of(context).buttonColor)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () { Navigator.pop(context);
                  onAccept();}, 
                ),
                FlatButton(
                  child: Text(denyButtonText, style:TextStyle(color: Theme.of(context).errorColor)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.pop(context), 
                )
          ],
        );
      }
    );
  }

  static DateFormat formatter = DateFormat('yyyy-MM-dd');

  // Reads all moods from the database
  static Future<List<Mood>> readMoodsFromId(int id) async {
    MoodModel _moodModel = new MoodModel();
    return await _moodModel.getMoodForUser(id);
  }

  static String getMoodValueName(Mood mood) {
    for (var i = 0; i < moodList.length; i++) {
      if (mood.mood == moodList[i].moodValue) {
        return moodList[i].name;
      }
    }
    return "";
  }

  static Color getMoodColor(Mood mood, UserBLoC userBLoC) {
    switch (mood.mood) {
      case 1:
        return userBLoC.colorOne;
        break;
      case 2:
        return userBLoC.colorTwo;
        break;
      case 3:
        return userBLoC.colorThree;
        break;
      case 4:
        return userBLoC.colorFour;
        break;
      case 5:
        return userBLoC.colorFive;
        break;
      case 6:
        return userBLoC.colorSix;
        break;
      default:
        return Colors.grey;
        break;
    }
  }

  // taken from: https://stackoverflow.com/questions/1855884/determine-font-color-based-on-background-color
  // Determines if the font color should be white or black to be visible
  static Color contrastColor(Color color) {
    int d = 0;
    // Counting the perceptive luminance - human eye favors green color... 
    double luminance = ( 0.299 * color.red + 0.587 * color.green + 0.114 * color.blue)/255;
    if (luminance > 0.5)
      d = 0; // bright colors - black font
    else
      d = 255; // dark colors - white font
    return  Color.fromARGB(255, d, d, d);
  }
}
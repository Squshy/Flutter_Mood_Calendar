// BLoC used for handling stuff with user interactions
// Stores preferred colors, and other user information
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../database/users/users.dart';

class UserBLoC with ChangeNotifier {
  bool loggedIn;

  Users _user = Users(
    username: null,
    password: null
  );
  
  // Get the user object
  Users get user => _user;

  // Gets if user is logged in
  bool get isLoggedIn => loggedIn;

  Color get colorOne => Color(int.parse(_user.moodColorOne));
  Color get colorTwo => Color(int.parse(_user.moodColorTwo));
  Color get colorThree => Color(int.parse(_user.moodColorThree));
  Color get colorFour => Color(int.parse(_user.moodColorFour));
  Color get colorFive => Color(int.parse(_user.moodColorFive));
  Color get colorSix => Color(int.parse(_user.moodColorSix));

  // Clears the user
  clearUser() {
    loggedIn = false;
    _user = new Users(
      username: null,
      password: null);
  }

  // Sets the user to a new user with the default colors
  newUser(Users user) {
    _user = user;
    notifyListeners();
  }

  // Creates a user object with existing user's info
  existingUser(Users user) {
    _user = user;
    notifyListeners();
  }

  // Sets the state of logged in to false
  userLogOut() {
    loggedIn = false;
    notifyListeners();
  }

  // Sets every color of the users' mood to that specified
  setAllMoodColors(Color color1, Color color2, Color color3, Color color4, Color color5, Color color6) {
    _user.moodColorOne = color1.value.toString();
    _user.moodColorTwo = color2.value.toString();
    _user.moodColorThree = color3.value.toString();
    _user.moodColorFour = color4.value.toString();
    _user.moodColorFive = color5.value.toString();
    _user.moodColorSix = color6.value.toString();
    notifyListeners();
  }

  // Sets the new color for mood 1
  set userMood1(Color color) {
    _user.moodColorOne = color.value.toString();
    notifyListeners();
  }

  // Sets the new color for mood 2
  set userMood2(Color color) {
    _user.moodColorTwo = color.value.toString();
    notifyListeners();
  }

  // Sets the new color for mood 3
  set userMood3(Color color) {
    _user.moodColorThree = color.value.toString();
    notifyListeners();
  }

  // Sets the new color for mood 4
  set userMood4(Color color) {
    _user.moodColorFour = color.value.toString();
    notifyListeners();
  }

  // Sets the new color for mood 5
  set userMood5(Color color) {
    _user.moodColorFive = color.value.toString();
    notifyListeners();
  }

  // Sets the new color for mood 6
  set userMood6(Color color) {
    _user.moodColorSix = color.value.toString();
    notifyListeners();
  }
}
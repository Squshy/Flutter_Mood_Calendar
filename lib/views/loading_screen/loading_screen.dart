// Loading screen / Splash screen for application
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mood/model/database/users/users.dart';
import 'package:mood/model/database/users/users_model.dart';
import 'package:mood/model/store/mood.dart';
import 'package:mood/model/store/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:provider/provider.dart';
// widgets
import './widgets/db_load_failure.dart';
import 'widgets/transition_screen.dart';
// Database
import '../../model/database/mood/mood.dart';
import '../../model/database/mood/mood_model.dart';
// utility
import '../../utility.dart';
// Testing adding dumymy data
import '../../test.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final _notifications = Notifications();
  bool _isLoggedIn;
  bool _isLoadingMoods = true;  // false when we retreived all moods
  bool _checkedForUser = false; // true when we have checked if a user exists
  MoodBLoC _moodBLoC;
  UserBLoC _userBLoC;
  // db models
  final _usersModel = UsersModel();

  @override
  void initState() {
    // On First load of page
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getLoggedInValue().then((value) => setState(() {
        _isLoggedIn = value;  // gets the value of logged in saved in preferences
        if(value) { // if the user was logged in
          _getLoggedInUser().then((value) { // look up the user by their saved ID
            _userBLoC.existingUser(value);  // Store the user in BLoC
            _checkedForUser = true; // Completed check for user

            // FOR TESTING PURPOSES
            // addEmBaby(value.id); // UN COMMENT / RE COMMENT TO FILL DATABASE WITH DUMMYDATA
            // END OF FOR TESTING PURPOSES

            Utility.readMoodsFromId(value.id).then((value) => setState(() {  // Read all moods from DB
              _moodBLoC.setAllMoods(value); // Set the moods in the BLoC
              _isLoadingMoods = false;  // Done getting all the moods
              _setTodaysMood(); // Set todays mood in BLoC
            }));
          });
        } else 
          _checkedForUser = true; // Completed check for user
          _moodBLoC.setAllMoods(<Mood>[]);
          _isLoadingMoods = false;  // Done getting all the moods
      })); // Check if user is logged in from shared preferences
       // read moods from database
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    _moodBLoC = context.watch<MoodBLoC>();
    _userBLoC = context.watch<UserBLoC>();

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          print(snapshot.error);
          return DBLoadFailure(); // Display a page warning of the failed db connect
        }
        tz.initializeTimeZones(); // initialize timezones for the notifications
        _notifications.init();  // initialize notifications
        _notifications.setupDailyMoodReminder();  // start daily notification service
        return new TransitionScreen(  // Displays title of app and loading icon while waiting
          "BallerSquad Mood App",
          _isLoggedIn,
          (snapshot.connectionState == ConnectionState.done && _isLoadingMoods == false && _checkedForUser));  // Determines if we navigate to next screen or not
      },
    );
  }

  // Checks if the user is logged in from shared preferences
  Future<bool> _getLoggedInValue() async {
    bool isLoggedIn;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool("isLoggedIn");
    if(isLoggedIn == null)
      return false;
    else return isLoggedIn;
  }

  // Gets the logged in user's ID from shared preferences
  Future<Users> _getLoggedInUser() async {
    int userID;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getInt("userID");
    return await _usersModel.getUserWithId(userID);
  }

  // Checks if today has been inputted already
  // If it has then set it in BLoC
  void _setTodaysMood() {
    if(_moodBLoC.allMoods.isNotEmpty){
      Mood lastMood = _moodBLoC.allMoods.last;  // Would be the last inserted mood in the DB
      DateTime today = DateTime.now();
      if(Utility.formatter.format(today) == Utility.formatter.format(lastMood.mdate)) {
        _moodBLoC.setTodaysMood(lastMood);  // Set mood to BLoC
      }
    }
  }
}
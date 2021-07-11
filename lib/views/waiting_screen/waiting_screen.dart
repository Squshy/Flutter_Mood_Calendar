// Used for displaying a loading screen after logging in
import 'package:flutter/material.dart';
import 'package:mood/model/store/mood.dart';
import 'package:mood/model/store/user.dart';
import 'package:mood/views/loading_screen/widgets/transition_screen.dart';
import 'package:provider/provider.dart';
import '../../utility.dart';
import '../../model/database/mood/mood.dart';

class WaitingScreen extends StatefulWidget {
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  UserBLoC _userBLoC;
  MoodBLoC _moodBLoC;
  bool _isLoadingMoods = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  // Run only when widget builds first time
      Utility.readMoodsFromId(_userBLoC.user.id).then((value) {
        setState(() {
          if(value.isNotEmpty) {
            _moodBLoC.setAllMoods(value); // set the bloc with all moods values
            _setTodaysMood();
          }
          _isLoadingMoods = false;  // done loading moods
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userBLoC = context.watch<UserBLoC>();
    _moodBLoC = context.watch<MoodBLoC>();
    return TransitionScreen("Loading", true, !_isLoadingMoods);
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
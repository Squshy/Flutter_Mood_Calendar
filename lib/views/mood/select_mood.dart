import 'package:flutter/material.dart';
import 'package:mood/model/store/mood.dart';
import 'package:mood/model/store/user.dart';
import 'package:mood/views/header/header.dart';
import 'package:mood/model/database/mood/mood_model.dart';
import 'package:mood/model/database/mood/mood.dart';
import 'package:mood/views/mood/widgets/diary_multi_text_field.dart';
import 'package:mood/views/mood/widgets/show_snack_bar.dart';
import '../../constants/selectable_moods.dart';
import 'package:provider/provider.dart';

import '../../utility.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

// User selects mood from like 5 or 6 icons and give them a text Field Form to type their feelings
// Create list pass it to row moods and in row moods display all the icons
class SelectMood extends StatefulWidget {
  @override
  SelectMoodState createState() => SelectMoodState();
}

class SelectMoodState extends State<SelectMood> {
  final _model = MoodModel();
  String _title;
  UserBLoC _userBLoC;
  MoodBLoC _moodBLoC ;
  Color _moodColor;

  //Stuff for Editing
  Mood _currentMood = Mood(mood: null, feelingDescription: null, mdate: null);
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (_moodBLoC.todaysMood.mdate != null) {
          _moodColor = Utility.getMoodColor(_moodBLoC.todaysMood, _userBLoC);
        } else {
          _moodColor = Theme.of(context).buttonColor;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _moodBLoC = context.watch<MoodBLoC>();
    _userBLoC = context.watch<UserBLoC>();

    // If Today's mood is null then we're adding
    // if it isn't then we're updating also pass today's mood to _currentMood
    if (_moodBLoC.todaysMood.mdate != null) {
      _currentMood = _moodBLoC.todaysMood;
      _title = "Edit today's mood";
    } else {
      _title = "Enter your mood for today";
    }

    return GestureDetector(
      child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () => submitMood(_moodBLoC),
            backgroundColor: _moodColor != null ? _moodColor : Colors.green,
            child: Icon(
              Icons.save,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          appBar: Header(isHome: false),
          body: Form(
            key: _formkey,
            child: Container(
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10), // space between items
                    Text(
                      _title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      )
                    ),
                    SizedBox(height: 15), // space between items
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [  // Display an inwards box shadow
                          BoxShadow(
                            color: Colors.grey
                          ),
                          BoxShadow(  
                            color: Theme.of(context).primaryColor,
                            spreadRadius: -5,
                            blurRadius: 15,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _createClickibleIcons(),
                      ),
                    ),
                    SizedBox(height: 15), // space between items
                    Text(
                      "Notes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left
                      ),
                    diaryMultiTextField(context, _currentMood, _moodColor),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // Checks if mood is editing or adding and does appropriate functionality accordingly
  void submitMood(MoodBLoC moodBLoC) {
    // User doesn't have to fill out the multilinetext
    if (_currentMood.feelingDescription == null) {
      _currentMood.feelingDescription = "";
    }

    // However they need to select a mood to successfully insert
    if (_currentMood.mood == null) {
      showSnackBar(
          context, "You must select a mood!", Colors.red, _scaffoldKey);
      // Inserting
    } else {
      if (moodBLoC.todaysMood.mdate == null) {
        _currentMood.mdate = DateTime.now();
        _addMood(_currentMood);
        moodBLoC.setTodaysMood(_currentMood);
        moodBLoC.setMood(_currentMood);
        SnackBar _sendSnackBar = showSnackBarPersist(
            context, "Mood has been inserted succesfully!", Colors.green);
        return Navigator.pop(context, _sendSnackBar);

        // Updating
      } else {
        _currentMood.mdate = DateTime.now();
        _editMood(_currentMood);
        moodBLoC.setTodaysMood(_currentMood);
        moodBLoC.setMood(_currentMood);
        SnackBar _sendSnackBar = showSnackBarPersist(
            context, "Mood has been updated succesfully!", Colors.green);
        return Navigator.pop(context, _sendSnackBar);
      }
    }
  }

  // Adds mood to DB
  Future<void> _addMood(Mood currentMood) async {
    currentMood.userId = _userBLoC.user.id;
    await _model.insertMood(currentMood);
  }

  // Edits the mood in DB
  Future<void> _editMood(Mood currentMood) async {
    currentMood.userId = _userBLoC.user.id;
    await _model.updateMood(currentMood);
  }

  // Returns a list of clickable icons to select a mood
  List<Widget> _createClickibleIcons() {
    List<Widget> widgetList = [];
    for (var i = 0; i < moodList.length; i++)
      widgetList.add(new IconButton(
        color: _currentMood.mood == moodList[i].moodValue
            ? Utility.getMoodColor(_currentMood, _userBLoC)
            : Colors.white,
        icon: moodList[i].iconName,
        onPressed: () {
          _currentMood.mood = moodList[i].moodValue;
          setState(() {
            _moodColor = Utility.getMoodColor(_currentMood, _userBLoC);
          });
        },
      ));
    return widgetList;
  }
}

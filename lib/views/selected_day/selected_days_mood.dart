import 'package:flutter/material.dart';
import 'package:mood/views/mood/widgets/show_snack_bar.dart';
import 'package:provider/provider.dart';
import '../../utility.dart';
import '../header/header.dart';

// db
import '../../model/database/mood/mood.dart';

// store
import '../../model/store/mood.dart';
import 'package:mood/model/store/user.dart';

class SelectedDaysMood extends StatefulWidget {
  @override
  _SelectedDaysMoodState createState() => _SelectedDaysMoodState();
}

class _SelectedDaysMoodState extends State<SelectedDaysMood> {
  MoodBLoC _moodBLoC;
  UserBLoC _userBLoC;
  Color _moodColor;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final Mood _mood;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _moodColor = Utility.getMoodColor(_moodBLoC.mood, _userBLoC);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _moodBLoC = context.watch<MoodBLoC>();
    _userBLoC = context.watch<UserBLoC>();

    return Scaffold(
      // Check for today's date and if true then a floating action button appears
      floatingActionButton: _displayFloatingActionButton(),
      key: _scaffoldKey,
      body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Utility.getMoodValueName(_moodBLoC.mood),
                        style: TextStyle(
                          color: _moodColor,
                          fontSize: 24,
                        )
                      ),
                      Text(Utility.formatter.format(_moodBLoC.mood.mdate),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontSize: 16,
                          )),
                    ],
                  ),
                ),
                Divider(
                  color: _moodColor,
                  thickness: 3.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      _checkForEmptyDescription(_moodBLoC.mood),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
              ],
            ),
          )),
      appBar: Header(isHome: false),
    );
  }

  _navigateUpdateAndDisplaySnackBar(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/selectMood');
    if (result != null) {
      _scaffoldKey.currentState.showSnackBar(result);
    } else {
      SnackBar failedResult = showSnackBarPersist(
          context, "Mood has not been updated.", Colors.red);
      _scaffoldKey.currentState.showSnackBar(failedResult);
    }
  }

  String _checkForEmptyDescription(Mood mood) {
    if (mood.feelingDescription == "" || mood.feelingDescription == null) {
      return "No notes were recorded for this day";
    }
    else return mood.feelingDescription;
  }

  FloatingActionButton _displayFloatingActionButton() {
    if(Utility.formatter.format(_moodBLoC.mood.mdate) == Utility.formatter.format(DateTime.now())) {
      return FloatingActionButton(
        onPressed: () {
          _navigateUpdateAndDisplaySnackBar(context);
        },
        backgroundColor: _moodColor,
        child: Icon(
          Icons.edit,
          color: Theme.of(context).backgroundColor
        ),
      );
    } else {
      return null;
    }
  }
}

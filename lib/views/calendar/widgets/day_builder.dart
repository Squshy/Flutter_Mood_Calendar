// Custom day builder used for the calendar builder
// Used to show custom colors depending on mood for the specified day
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// db
import '../../../model/database/mood/mood.dart';
// store
import '../../../model/store/user.dart';
import '../../../model/store/mood.dart';
import 'package:mood/views/mood/widgets/show_snack_bar.dart';
import '../../../utility.dart';

class DayBuilder extends StatelessWidget {
  DayBuilder(this._date, this._mood);

  final DateTime _date;
  final Mood _mood;

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserBLoC, MoodBLoC>(
        builder: (context, userBLoC, moodBLoC, child) {
      return GestureDetector(
        onTap: () {
          _checkDate(context, moodBLoC);
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              '${_date.day}',
              style: TextStyle().copyWith(
                fontSize: 16.0,
                color: Utility.contrastColor(_getColor(
                  _mood, userBLoC))
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: _getColor(_mood, userBLoC), // display color for the day based on mood
            border: _todaysDateStyles(context, userBLoC),
          ),
        ),
      );
    });
  }

  // Displays a border around todays date to easily see it
  Border _todaysDateStyles(BuildContext context, UserBLoC userBLoC) {
    if(Utility.formatter.format(_date) == Utility.formatter.format(DateTime.now())) {
      return Border(
        right: BorderSide(
          width: 2,
          color: Utility.contrastColor(_getColor(_mood, userBLoC)).withAlpha(150)
        ),
        left: BorderSide(
          width: 2,
          color: Utility.contrastColor(_getColor(_mood, userBLoC)).withAlpha(150)
        ),
        top: BorderSide(
          width: 2,
          color: Utility.contrastColor(_getColor(_mood, userBLoC)).withAlpha(150)
        ),
        bottom: BorderSide(
          width: 2,
          color: Utility.contrastColor(_getColor(_mood, userBLoC)).withAlpha(150)
        ),
      );
    }
    return Border();
  }

  // Returns a color depending on the mood
  Color _getColor(Mood mood, UserBLoC bloc) {
    Color color = Colors.grey[700].withAlpha(70);
    if (mood != null) {
      switch (mood.mood) {
        case 1:
          color = bloc.colorOne;
          break;
        case 2:
          color = bloc.colorTwo;
          break;
        case 3:
          color = bloc.colorThree;
          break;
        case 4:
          color = bloc.colorFour;
          break;
        case 5:
          color = bloc.colorFive;
          break;
        case 6:
          color = bloc.colorSix;
          break;
        default:
          color = Colors.grey[700].withAlpha(70);
      }
    }
    return color;
  }

  _checkDate(BuildContext context, MoodBLoC moodBLoC) {
    // If User selects on today's date and hasn't input anything go to select mood
    if (Utility.formatter.format(_date) == Utility.formatter.format(DateTime.now()) &&
        _mood == null) {
      _navigateInsertAndDisplaySnackBar(context);
      // Navigator.pushNamed(context, '/selectMood');
    } else if (_mood != null) {
      moodBLoC.setMood(_mood);
      // _navigateInsertAndDisplaySnackBar(context);
      Navigator.pushNamed(context, '/selectedDaysMood');
    }
  }

  _navigateInsertAndDisplaySnackBar(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/selectMood');
    if (result != null) {
      // _scaffoldKey.currentState.showSnackBar(result);
      Scaffold.of(context).showSnackBar(result);
    } else {
      SnackBar failedResult = showSnackBarPersist(
          context, "Mood has not been inserted.", Colors.red);
      // _scaffoldKey.currentState.showSnackBar(failedResult);
      Scaffold.of(context).showSnackBar(failedResult);
    }
  }
}

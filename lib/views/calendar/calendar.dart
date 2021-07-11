// Mood Calendar overview
// Allows for seeing your monthly moods in calendar view
// Uses the Table Calendar plugin for flutter
import 'package:flutter/material.dart';
import 'package:mood/model/store/mood.dart';
import 'package:mood/views/header/header.dart';
import 'package:table_calendar/table_calendar.dart';
// Widgets
import '../../utility.dart';
import './widgets/day_builder.dart';
// properties
import './properties/calendar_properties.dart'; // properties stored here so file doesnt look as intimidating
// Database
import '../../model/database/mood/mood.dart';
import 'package:provider/provider.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  MoodBLoC moodBLoC;
  CalendarController _calendarController;


  // mood form
  int insertID;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    moodBLoC = context.watch<MoodBLoC>();

    return Scaffold(
      body: _displayMain(context),
      appBar: Header(isHome: false),
    );
  }

  Widget _displayMain(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TableCalendar(
            calendarController: _calendarController,
            initialCalendarFormat: CalendarFormat.month,
            formatAnimation: FormatAnimation.slide,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekStyle: customDaysOfWeekStyle,
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {CalendarFormat.month: "Month"},
            calendarStyle: customCalendarStyle,
            headerStyle: customHeaderStyle(context),
            builders: CalendarBuilders(
              dayBuilder: (context, date, events) {
                return new DayBuilder(date, _checkForMood(date)); // custom day builder for each day
              },
            ),
          )
        ],
      ),
    );
  }

  // Functions

  // Used to pass a mood through to day builder
  Mood _checkForMood(DateTime date) {
    for (int i = 0; i < moodBLoC.allMoods.length; i++) {
      if (Utility.formatter.format(date) ==
          Utility.formatter.format(moodBLoC.allMoods[i].mdate)) {
        // check if dates are same
        return moodBLoC.allMoods[i];
      }
    }
    return null;
  }
}

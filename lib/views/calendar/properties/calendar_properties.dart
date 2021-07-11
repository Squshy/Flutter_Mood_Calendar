// Calendar Properties
// Stores properties for the calendar builder
// Seperated into own file due to clunkiness of the properties 

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// final HeaderStyle customHeaderStyle = _customHeaderStyle();
final CalendarStyle customCalendarStyle = _customCalendarStyle();
final DaysOfWeekStyle customDaysOfWeekStyle = _customDaysOfWeekStyle();

// The custom header style for the calendar
HeaderStyle customHeaderStyle(BuildContext context) {
  return new HeaderStyle(
    centerHeaderTitle : true,
    formatButtonVisible: false,
    leftChevronIcon: Icon(
      Icons.chevron_left,
      color: Theme.of(context).accentIconTheme.color,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right,
      color: Theme.of(context).accentIconTheme.color,
    ),
    titleTextStyle: Theme.of(context).textTheme.headline4,
  );
}

// Custom calendary style for calendar
CalendarStyle _customCalendarStyle() {
  return const CalendarStyle(  
    outsideDaysVisible: false,
  );
}

// Custom day of the week style for calendar
DaysOfWeekStyle _customDaysOfWeekStyle() {
  return const DaysOfWeekStyle(
    weekdayStyle: TextStyle(color: Colors.grey),
    weekendStyle: TextStyle(color: Colors.grey),
  );
}
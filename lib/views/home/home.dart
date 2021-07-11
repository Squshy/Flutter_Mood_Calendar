// Homepage for the application
// Displays 2 buttons to edit/add a mood and prompts to visit the calendar
// Displays a fancy animation at the bottom of the screen
import 'package:flutter/material.dart';
import 'package:mood/model/store/mood.dart';
import 'package:mood/views/home/widgets/button_text_display.dart';
import 'package:provider/provider.dart';
// Widgets
import '../nav/nav.dart';
import 'package:mood/views/header/header.dart';
import 'package:mood/views/home/widgets/home_greeting.dart';
import './widgets/fancy.dart';

// FANCY WAVES TAKEN FROM SIMPLE ANIMATIONS GITHUB EXAMPLES REPOSITORY
// https://github.com/felixblaschke/simple_animations/blob/master/example/lib/examples/fancy_background.dart

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MoodBLoC _moodBLoC;

  @override
  Widget build(BuildContext context) {
    // addEmBaby(); // It doesn't work on main.dart, have to be here and you have to restart for the first time
    
    _moodBLoC = context.watch<MoodBLoC>();
    print(_moodBLoC.allMoods.toString());
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: HomeGreeting()),
          if (_moodBLoC.todaysMood.mdate != null) // IF they havent selected a mood yet for today
            Expanded(
              flex: 3,
              child: ButtonAndTextDisplay(
                  "Maybe your mood has changed today?  Record that now.",
                  "Edit your daily mood",
                  "/selectMood",
                  Colors.blue[900],
                  Theme.of(context).backgroundColor)
              // EditTodaysMood()
              )
          else
            Expanded(
              flex: 3,
              child: ButtonAndTextDisplay(
                  "You haven't added a mood for today yet.  Why not do that now?",
                  "Let's add a mood",
                  "/selectMood",
                  Colors.blue[900],
                  Theme.of(context).backgroundColor)),
          Expanded(
            flex: 3,
            child: ButtonAndTextDisplay(
                "Wanna see how you've been doing this year?  Check out the calendar!",
                "View calendar",
                "/calendar",
                Colors.green[600],
                Theme.of(context)
                    .primaryColor) // Displays advert for calendar
            ),
          Expanded(
            flex: 5,
            child: FancyBackgroundApp(
                Container()) // Does the funky background from simple_animations
            ),
        ],
      ),
      appBar: Header(isHome: true),
      drawer: Nav(),
    );
  }
}

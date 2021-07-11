// Navigation for application
// Drawer widget which is shown after nav icon in header is clicked
// Holds navigational pages with a specific icon, title, and route
import 'package:flutter/material.dart';
import 'package:mood/model/database/mood/mood.dart';
import 'package:mood/model/store/mood.dart';
import 'package:mood/model/store/user.dart';
import 'package:mood/views/nav/widgets/nav_header.dart';
import 'package:mood/views/nav/widgets/nav_widget.dart';
import '../../constants/nav_items.dart';
import 'package:provider/provider.dart';

import '../../utility.dart';

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBLoC _userBLoC = context.watch<UserBLoC>();
    final MoodBLoC _moodBLoC = Provider.of<MoodBLoC>(context, listen: false);

    return Drawer(
      elevation: 0, // no shadow
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Flex(  
          direction: Axis.vertical, 
          children: _buildNavItems(context, _userBLoC, _moodBLoC),
        ),
      ),
    );
  }

  // Builds a list of widgets to be displayed in the body of the Nav
  List<Widget> _buildNavItems(BuildContext context, UserBLoC userBLoC, MoodBLoC moodBLoC) {
    List<Widget> items = [];
    List<Color> colors = [];  // display separate colors

    colors.add(userBLoC.colorOne);
    colors.add(userBLoC.colorTwo);
    colors.add(userBLoC.colorThree);
    colors.add(userBLoC.colorFour);
    colors.add(userBLoC.colorFive);
    colors.add(userBLoC.colorSix);
    int colorCounter = 0;

    items.add(NavHeader());
    for(NavItem nav in navItems) {  // add a new widget to be displayed
      if(colorCounter >= colors.length)
        colorCounter = 0; // reset color counter once it hits edge
      if(nav.route != "/logout")
        items.add(NavWidget(
          nav.translationKey, 
          nav.icon, 
          colors[colorCounter],
          ()  {Navigator.pop(context); Navigator.pushNamed(context, nav.route);}));  // allow navigation
      else
        items.add(NavWidget(
          nav.translationKey, 
          nav.icon, 
          Colors.grey,
          () => Utility.saveConfirmationDialog(context, () => _logout(context, userBLoC, moodBLoC), "Logout", "No", "Are You sure you want to logout?", "Yes")));  // display logout modal

      colorCounter++;
    }
    return items;
  }
  // When called, will update database to new colors saved in state
  // Updates BLoC to use new colors as well
  // Returns user from color options to general settings page
  void _logout(BuildContext context, UserBLoC userBLoC, MoodBLoC moodBLoC) {
    userBLoC.clearUser();
    moodBLoC.setAllMoods([]);
    moodBLoC.setTodaysMood(new Mood(mdate: null));
    Navigator.of(context).pushReplacementNamed('/login');
  }
}

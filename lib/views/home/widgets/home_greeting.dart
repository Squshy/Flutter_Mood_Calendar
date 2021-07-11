// Displays a greeting on the home screen
import 'package:flutter/material.dart';
import 'package:mood/model/store/user.dart';
import 'package:provider/provider.dart';

class HomeGreeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBLoC _userBLoC = context.watch<UserBLoC>();

    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Theme.of(context).primaryColor, width: 2))),
      child: 
        Center(
          child: Text(
            "Hey there ${_userBLoC.user.username}, welcome back!",
            style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).textTheme.headline1.color),
            textAlign: TextAlign.center,
          ),
        ),
    );
  }
}

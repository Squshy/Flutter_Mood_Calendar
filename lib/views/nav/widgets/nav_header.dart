// Top most item in the nav
import 'package:flutter/material.dart';
import 'package:mood/model/store/user.dart';
import 'package:provider/provider.dart';

class NavHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBLoC _userBLoC = context.watch<UserBLoC>();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.grey[700]
          )
        )
      ),
      child: Text(
        "Lookin good, ${_userBLoC.user.username}",  // Display the user's username
        textAlign: TextAlign.left,
        style: TextStyle(  
          color: Theme.of(context).textTheme.headline3.color,
          fontStyle: FontStyle.italic
        )
      ),
    );
  }
}
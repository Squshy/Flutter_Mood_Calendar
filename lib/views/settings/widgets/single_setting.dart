// Single Setting
// Takes name, icon, and route as parameters to display an item for the list view in the settings page
import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

class SingleSetting extends StatelessWidget {
  final String name;
  final IconData icon; 
  final String route;
  final Function refresh;
  SingleSetting({@required this.name, @required this.icon, @required this.route, @required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        )
      ),
      child: ListTile(
        title: Text(FlutterI18n.translate(context, name)),  // settings name
        trailing: Icon(icon), // settings icon
        onTap: () => Navigator.pushNamed(context, route).then((value) => this.refresh()), // settings route
        // ,then() => to refresh the settings page so that the widget can be redrawn with newly changed text if it is settings page
      ),
    );
  }
}
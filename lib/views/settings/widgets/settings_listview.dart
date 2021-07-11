import 'package:flutter/material.dart';
// widgets
import '../widgets/single_setting.dart';

import '../../../constants/settings.dart';

// Builds a listview of all the settings in the setting list
// Element returned is a custom widget displaying the settings name, icon and clickable route
class SettingsListView extends StatelessWidget {
  final Function refresh; // refresh parent widget
  SettingsListView({Key key, @required this.refresh});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settings.length,
      itemBuilder: (BuildContext context, int i) {
        return SingleSetting(
          name: settings[i].translationKey, 
          icon: settings[i].icon, 
          route: settings[i].route,
          refresh: this.refresh,
        );
      }
    );
  }
}
// Settings page
// Contains a list of settings to display
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

// widgets
import './widgets/settings_listview.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

// Stateful so we can setState() to redraw widget after popping from changing settings
// Otherwise popping from changing language settings, the language for this page wont change
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text(FlutterI18n.translate(context, "settings.title")),
        shadowColor: Colors.transparent,
      ),
      body: SettingsListView(refresh: () => setState(() => null),),
    );
  }
}
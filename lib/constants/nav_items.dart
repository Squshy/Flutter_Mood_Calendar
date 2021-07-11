import 'package:flutter/material.dart';

// Class for NavItems
class NavItem {
  IconData icon;
  String translationKey;
  String route;

  NavItem({@required this.icon, @required this.translationKey, @required this.route});
}

// List of nav items, consists of their route and their title and an icon for display
List<NavItem> navItems = [
  NavItem(icon: Icons.calendar_today, translationKey: "nav.mood_calendar", route: "/calendar"),
  NavItem(icon: Icons.tag_faces, translationKey: "nav.select_mood", route: "/selectMood"),
  NavItem(icon: Icons.table_chart, translationKey: "nav.chart", route: "/moodChart"),
  NavItem(icon: Icons.insert_chart, translationKey: "nav.graph", route: "/moodBar"),
  NavItem(icon: Icons.map, translationKey: "nav.map", route: "/map"),
  NavItem(icon: Icons.settings, translationKey: "nav.settings", route: "/settings"),
  NavItem(icon: Icons.exit_to_app, translationKey: "nav.logout", route: "/logout"),
];
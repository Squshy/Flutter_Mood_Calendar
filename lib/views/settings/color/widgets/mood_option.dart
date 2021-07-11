// Single widget which displays an icon, description, and color for a mood
// Has a function which shows a palette picker to update the color
import 'package:flutter/material.dart';
import 'package:mood/constants/selectable_moods.dart';

class MoodOption extends StatelessWidget {
  final MoodIcons mood;
  final int ind;
  final Color color;
  final Function selectColor;

  MoodOption({Key key, 
    @required this.mood, 
    @required this.color, 
    @required this.ind, 
    @required this.selectColor
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: () => selectColor(mood, color),  // Displays a palette picker for selecting a new color
        child: Container(
          decoration: BoxDecoration(
            // Displays the color gradient in the left of the widget
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: ind % 2 == 0 ? Alignment(0.8, 0.1) : Alignment(0.8, -0.1), // if the index of the item in the list can be divided by 2 apply a certain alignment.  This will show the zig zag effect
              colors: <Color>[
                color != null ? color : Theme.of(context).primaryColor, // stops an error where color can be null
                Theme.of(context).backgroundColor
              ]
            ),
            border: Border(
              top: BorderSide(  
                color: Colors.white.withAlpha(25),
                width: ind == 0 ? 1 : .5  // if its the first item then have different border settings
              ),
              left: BorderSide(
                color: color != null ? color : Theme.of(context).primaryColor, 
                width: 3
              ),
              right: BorderSide(
                color: color != null ? color : Theme.of(context).primaryColor, 
                width: 20
              ),
              bottom: BorderSide(
                color: Colors.white.withAlpha(25),
                width: ind == moodList.length - 1 ? 1 : .5  // if its the last item then have different border settings
              ),
            )
          ),
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(  // IconButton because Icon doesnt seem to work with favicons
                icon: mood.iconName,
                iconSize: 50,
                disabledColor: color,
              ),
              Text( // Displays mood description text
                mood.name,
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
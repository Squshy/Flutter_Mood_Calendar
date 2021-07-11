import 'package:flutter/material.dart';
import 'package:mood/model/database/mood/mood.dart';

Padding diaryMultiTextField(BuildContext context, Mood currentMood, Color color) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Container(
      height: MediaQuery.of(context).size.height * .4,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 3,
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: new TextEditingController(
              text: currentMood.feelingDescription
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'So how how you really feel...?',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: color == null ? Colors.grey : color
                )
              ),
              labelStyle: TextStyle(  
                color: color == null ? Colors.grey : color,
              )
            ),
            onChanged: (String value) {
              currentMood.feelingDescription = value;
            },
          )
        ],
      ),
    ),
  );
}

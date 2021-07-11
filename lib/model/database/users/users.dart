
//users class for local db interaction 

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Users {
  Users({
    @required this.username, 
    @required this.password,
    this.gender,
    this.birthday,
  }):
    // Default colors for a new user when user object is created
    // Get the value of the color and then store it as a string
    // The value is an int, when we use color again just convert string to int and get color
    moodColorOne = Colors.blue[900].value.toString(),
    moodColorTwo = Colors.blue.value.toString(),
    moodColorThree = Colors.lightGreen[700].value.toString(),
    moodColorFour = Colors.lightGreen[800].value.toString(),
    moodColorFive = Colors.green[700].value.toString(),
    moodColorSix = Colors.red[900].value.toString()
  ;

  int id;
  String username;
  String password;
  int isLoggedIn;
  String gender;
  DateTime birthday;
  static DateFormat formatter = DateFormat('yyyy-MM-dd');
  String moodColorOne;
  String moodColorTwo;
  String moodColorThree;
  String moodColorFour;
  String moodColorFive;
  String moodColorSix;

  Users.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.username = map['username'];
    this.password = map['password'];
    this.isLoggedIn = map['isLoggedIn'];
    this.gender = map['gender'];
    this.birthday = DateTime.parse(map['birthday']);
    this.moodColorOne = map['moodColorOne'];
    this.moodColorTwo = map['moodColorTwo'];
    this.moodColorThree = map['moodColorThree'];
    this.moodColorFour = map['moodColorFour'];
    this.moodColorFive = map['moodColorFive'];
    this.moodColorSix = map['moodColorSix'];

  }

  Map<String, dynamic> toMap(){
    return{
      'id': this.id,
      'username': this.username,
      'password': this.password,
      'isLoggedIn': 1,
      'gender': this.gender,
      'birthday': birthday == null ? null : Users.formatter.format(birthday),
      'moodColorOne': this.moodColorOne,
      'moodColorTwo': this.moodColorTwo,
      'moodColorThree': this.moodColorThree,
      'moodColorFour': this.moodColorFour,
      'moodColorFive': this.moodColorFive,
      'moodColorSix': this.moodColorSix,

    };
  }

  String toString() {
    return 'Users{id: $id, username: $username, password: $password, gender: $gender, birthday: $birthday, color1: $moodColorOne, color2: $moodColorTwo, color3: $moodColorThree, color4: $moodColorFour. color5: $moodColorFive, color6: $moodColorSix}';
  }


}
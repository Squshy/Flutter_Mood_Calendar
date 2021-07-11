import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import local database classes needed
import '../../model/database/users/users.dart';
import '../../model/database/users/users_model.dart';
import '../../utility.dart';
//registration class 
class Registration {
  //local variables
  String _registrationUsername;
  String _registrationPassword;
  String _confirmPassword;
  String _gender = "Male";


//method to insert the new user and add to bloc
Future<void> _submitRegistration(Users user, UserBLoC bloc, BuildContext context) async {

    UsersModel model = new UsersModel();
    int id = await model.insertUsers(user);
    if(id != null){
    user = await model.getUserWithId(id);
    print(user.toString());
    //submits the new user to the cloud db
    FirebaseFirestore.instance.collection('users')
    .add({
      'id': user.id,
      'username': user.username,
      'password': user.password,
      'gender': user.gender,
      'birthday': Users.formatter.format(user.birthday),
    });
    //sets the flag for shared preferences so no need to log in everytime
    Utility.createPersistentData(model, user);
    //add user to bloc
    bloc.existingUser(user);
    }
  } 

  // method for the design of the dialog registration form 
  openRegistration(context) {
    final UserBLoC userBLoC = Provider.of<UserBLoC>(context, listen:false);
    final _formKey1 = GlobalKey<FormState>();
    String dropdownValue = 'Male';
    showDialog(
      context: context,
      builder: (BuildContext context) {
          DateTime date = DateTime.now();
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          //rounded corners
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
            ), 
          content: StatefulBuilder(
          builder: (context, setState){
          //this allows for the for in dialog to be scrollable when to big
          return SingleChildScrollView(
            child: Container(
              height: 441.0,
              width: 120.0,
              //the registration form
            child: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Center(
                child: RichText(
                  text: TextSpan(
                    text:'Register',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 19)
                  )
                    )
              ),
                
                 TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                    color: Colors.white)
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'username is required';
                    }
                    if(value.length > 12){
                      return 'Must not be greater than 12 chars';
                    }
                    _registrationUsername = value;
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                    color: Colors.white)
                  ),
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'password is required';
                    }
                    if(value.length > 12){
                      return 'Must not be greater than 12 chars';
                    }
                    _registrationPassword = value;
                    return null;
                  },
                ), 
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                    color: Colors.white)
                  ),
                  obscureText: true,
                  validator: (String value) {
                    //makes sure the confirm password is entered
                    if (value.isEmpty) {
                      return 'You must put your password in a second time to confirm';
                    }
                    //makes sure the passwords are the same
                     if(value != _registrationPassword){
                       return 'Passwords must match';
                     }
                    _confirmPassword = value.trim();
                    return null;
                  },
                ),
                //dropdown button for gender
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 18,
                  elevation: 16,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      _gender = dropdownValue;
                    });
                  },
                  //validator: (value) => value == null ? 'Drop down field Required' : null ,
                  items: <String>['Male', 'Female', 'Other'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Center(child: 
                RichText(
                  text: 
                  TextSpan(
                    //displays the currently selected birthday
                  text: "\nBirthday: ${date.year}/${date.month}/${date.day}",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                  )
                  )),
                  Center(child: 
                  ButtonTheme(
                    height: 20.0,
                  child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    //date picker to choose your birthday
                    showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1980, 8),
                      lastDate: DateTime(2101)
                    ).then((value){
                    setState(() {
                      date = DateTime(value.year, value.month, value.day, date.hour, date.minute,date.second,);
                    });
                  });
                  },
                  child: Text("Please select your birthday", style: TextStyle(color: Colors.grey),)
                )
              )
              ),
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  child: Text('Submit'),
                    onPressed: () {
                      //checks if everything is validated
                        if (_formKey1.currentState.validate()) {
                        Users user = new Users(username: _registrationUsername.trim(), password: _registrationPassword.trim(), gender: _gender, birthday: date);
                        print(_gender);
                        _submitRegistration(user, userBLoC, context);
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    },
                  )),
                ],
              ),
            )
        ),
          );
          }),
      );
    });
  }
}
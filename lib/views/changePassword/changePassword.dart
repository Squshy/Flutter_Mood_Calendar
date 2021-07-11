import 'package:flutter/material.dart';
import 'package:mood/model/database/users/users_model.dart';
import 'package:mood/model/store/user.dart';
import 'package:mood/views/header/header.dart';
import 'package:provider/provider.dart';
class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //local variables
  String _password;
  String _confirmPassword;
  @override
  Widget build(BuildContext context) {
    //instantiation of bloc
    UserBLoC _userBLoC = Provider.of<UserBLoC>(context);
    final _formKey1 = GlobalKey<FormState>();
    return Scaffold(
      appBar: Header(isHome: false),
      //the change password form
          body: Form(
            key: _formKey1,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                RichText(
                text: TextSpan(
                  text:'Change Password',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25)
            )
            ),
              
                      //checks if everything is validated
                        TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                    color: Colors.white)
                  ),
                  obscureText: true,
                  validator: (String value) {
                    //check if password is inputted
                    if (value.isEmpty) {
                      return 'password is required';
                    }
                    //check if password is greater than 12 characters
                    if(value.length > 12){
                      return 'Must not be greater than 12 chars';
                    }
                    _password = value.trim();
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
                     if(value != _password){
                       return 'Passwords must match';
                     }
                    _confirmPassword = value.trim();
                    return null;
                  },
                ),
  
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  child: Text('Submit'),
                    onPressed: () {
                      //checks if everything is validated
                        if (_formKey1.currentState.validate()) {
                        UsersModel model = new UsersModel();
                        //send to db to update password
                        model.updateUsersPassword(_password, _userBLoC.user.id); 
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    },
                  )),
                    
                  
              ]
            )

          )
      
    );
  }
}



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import local database classes needed
import '../../model/database/users/users.dart';
import '../../model/database/users/users_model.dart';
import 'registration.dart';
import '../../utility.dart';
// store 
import '../../model/store/user.dart';
class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserBLoC _userBLoC;
  //unique form key
  final _formKey = GlobalKey<FormState>();

  Registration _registration = new Registration();

  // private variables for form validation and setting them to query db
  String _username;
  String _password;
  String _error = "";

  // query the db and show error if no match, if match go to home page
  Future<void> _getData(Users user) async {
    UsersModel model = new UsersModel();
    user = await model.getUserWithUsernameAndPassword(user.username, user.password);
    if (user == null) {
      _error = "Your username or password do not match our records";
      Utility.showError(context, _error);
    } else {
      Utility.createPersistentData(model, user);
      // Update the BLoC so that it stores the users' colors and id
      _userBLoC.existingUser(user);
      // Send user to home page
      Navigator.of(context).pushReplacementNamed('/waitingScreen');
    }
  }
  // overridden build method for login widget
  @override
  Widget build(BuildContext context) {
    //instantiate user bloc
    _userBLoC = Provider.of<UserBLoC>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        //login form
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text:'Login',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25)
            )
            ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                  labelStyle: TextStyle(
                  color: Colors.white)
                ),
                //check if username is empty
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'username is required';
                  }
                  _username = value;
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                  labelStyle: TextStyle(
                  color: Colors.white)
                ),
                //make the password not visible
                obscureText: true,
                //check if password is empty
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'password is required';
                  }
                  _password = value;
                  return null;
                },
              ),
              //creates space between text field and button
              SizedBox(height: 10), 
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                color: Theme.of(context).buttonColor,
                child: Text('Submit'),
                onPressed: () {
                  //checks if everything validates then submits and queries db
                  if (_formKey.currentState.validate()) {
                    Users user = new Users(username: _username.trim(), password: _password.trim());
                    _getData(user);
                  }
                },
              )),
              Container(
                alignment: Alignment.center,
                child: RichText(
                text: TextSpan(
                  text: 'Create an Account',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //opens the registration dialog
                        _registration.openRegistration(context);
                    }
                  )
              )),
            ],
          ),
        ),
      ),
    );
  }
}
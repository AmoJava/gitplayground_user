import 'package:flutter/material.dart';

import '../playgroundlist.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  static const String id = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
            Image.asset("assets/log.png"),
            TextFormField(),
            TextFormField(),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context,PlayGroundList.id);
            }, child: Text("Sign in")),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context,SignUp.id);
            }, child: Text("Sign up")),
          ],),
        ),
      ),
    );

  }
}


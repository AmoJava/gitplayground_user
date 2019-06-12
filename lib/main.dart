import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground_user/auth/Login.dart';
import 'package:playground_user/User/ConfirmationPage.dart';
import 'package:playground_user/User/Payment.dart';
import 'User/playgroundlist.dart';
import 'auth/Wellcome.dart';
import 'auth/Signup.dart';
import 'package:playground_user/PlayGroundadmin/root_page.dart';
import 'package:playground_user/PlayGroundadmin/authentication.dart';

void main() {
  runApp(MaterialApp(

    initialRoute: "splash",

     routes: {
    "splash": (context) => spalsh_screen(),
      Login.id: (context) => Login(),
      SignUp.id: (context) => SignUp(),
      PlayGroundList.id: (context) => PlayGroundList(),
      //ReservationPage.id: (context) => ReservationPage(),
       //Confirmation.id: (context) => Confirmation(),
      Payment.id: (context) => Payment(),
    },
  ));
}


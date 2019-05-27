//27/5/2019
//بسم الله الرحمن الرحيم

import 'package:flutter/material.dart';

import 'package:playground_user/auth/Login.dart';
import 'package:playground_user/playgroundlist.dart';
import 'ConfirmationPage.dart';
import 'Payment.dart';
import 'Reservationpage.dart';
import 'auth/Wellcome.dart';
import 'auth/Signup.dart';

void main() {
  runApp(MaterialApp(
    home: Wellcome(),
    routes: {
      Login.id: (context) => Login(),
      SignUp.id: (context) => SignUp(),
      PlayGroundList.id: (context) => PlayGroundList(),
      ReservationPage.id: (context) => ReservationPage(),
      Confirmation.id: (context) => Confirmation(),
      Payment.id: (context) => Payment(),
    },
  ));
}

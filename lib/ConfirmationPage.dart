import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Confirmation extends StatefulWidget {
  static const String id = "Confirmation";
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(onPressed: addReservationtodb, child: Text("upload data")),
        ),
      ),
    );
  }
}

addReservationtodb(){

  Map<String, dynamic> addReservedHour = {
    'userName': "amo",
    'userID': "Ghgffgfg211fgfgfgfgfgfg",
    'userEmail': "ph.ahmedmohsin@gmai.com",
    "userProfilePic":"httppp/gjgjhgjhgjhg",
    'dateOfReservation': "${getDateofnow()}",
    'isReserved': true ,
    "paymentConfirmed" : true ,
    "paymentMethod": "visa",
    "operationNumber": 2121512121212442

  };

  Firestore.instance
      .collection('pgs')
      .document("fifa")
      .collection("30 May")
      .document("h11")
      .setData(addReservedHour);
  print("upload done");
}



String getDateofnow() {
  var now = DateTime.now();
  //to write the name of the day write mmm ,,,, iif mm will write num
  var dateFormat = DateFormat('dd MMM yyyy  @ hh:mm').format(now);
  return dateFormat;
}

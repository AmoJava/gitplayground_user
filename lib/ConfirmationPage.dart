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
        child: Column(
          children: <Widget>[
            Text("you resrve"),
            Text("")
          ],

        ),
      ),
    );
  }
}

addReservationtodb(int inty, String date) {

  Map<String, dynamic> addReservedHour = {
    //'userName': "amo",
    //'userID': "Ghgffgfg211fgfgfgfgfgfg",
    //'userEmail': "ph.ahmedmohsin@gmai.com",
    //"userProfilePic":"httppp/gjgjhgjhgjhg",
    //'dateOfReservation': "${getDateofnow()}",
    'isReserved': true ,
    //"paymentConfirmed" : true ,
    //"paymentMethod": "visa",
    //"operationNumber": 2121512121212442

  };

  Firestore.instance
      .collection('pgs')
      .document("ahly")
      .collection("$date")
      .document("h$inty")
      .setData(addReservedHour);
  print("upload done");
}



String getDateofnow() {
  var now = DateTime.now();
  //to write the name of the day write mmm ,,,, iif mm will write num
  var dateFormat = DateFormat('dd MMM yyyy  @ hh:mm').format(now);
  return dateFormat;
}

/*FlatButton(onPressed: (){

            addReservationtodb(00, "2 june");
            addReservationtodb(01, "2 june");
            addReservationtodb(02, "2 june");
            addReservationtodb(03, "2 june");
            addReservationtodb(04, "2 june");
            addReservationtodb(05, "2 june");
            addReservationtodb(06, "2 june");
            addReservationtodb(07, "2 june");
            addReservationtodb(08, "2 june");
            addReservationtodb(09, "2 june");
            addReservationtodb(10, "2 june");
            addReservationtodb(11, "2 june");
            addReservationtodb(12, "2 june");
            addReservationtodb(13, "2 june");
            addReservationtodb(14, "2 june");
            addReservationtodb(15, "2 june");
            addReservationtodb(16, "2 june");
            addReservationtodb(17, "2 june");
            addReservationtodb(18, "2 june");
            addReservationtodb(19, "2 june");
            addReservationtodb(20, "2 june");
            addReservationtodb(21, "2 june");
            addReservationtodb(22, "2 june");
            addReservationtodb(23, "2 june");



          }, child: Text("upload data"))*/
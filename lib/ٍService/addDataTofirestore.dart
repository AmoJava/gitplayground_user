import 'package:cloud_firestore/cloud_firestore.dart';

addReservationtodb(int inty, String date) {
  Map<String, dynamic> addReservedHour = {
    'color': 'green',
    'index': inty,
    //'userName': "amo",
    //'userID': "Ghgffgfg211fgfgfgfgfgfg",
    //'userEmail': "ph.ahmedmohsin@gmai.com",
    //"userProfilePic":"httppp/gjgjhgjhgjhg",
    //'dateOfReservation': "${getDateofnow()}",
    'isReserved': true,
    //"paymentConfirmed" : true ,
    //"paymentMethod": "visa",
    //"operationNumber": 2121512121212442
  };

  Firestore.instance
      .collection('pgs')
      .document("damana")
      .collection("$date")
      .document("h$inty")
      .setData(addReservedHour);
  print("upload done");
}

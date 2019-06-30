import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:playground_user/User/congratulation.dart';
import 'package:playground_user/User/httpget.dart';

class Payment extends StatefulWidget {
  static const String id = "Paymemt";
String uid , umail ;
int month , day ;
Payment({this.uid,this.umail,this.month,this.day});
  @override
  _PaymentState createState() => _PaymentState();
}

getuid(){

}

class _PaymentState extends State<Payment> {
  String refNum  ;
  String merchCode = "1PC8/vkn3GzHnfhDcneBrA==";
  String secureCode = "aa8f660ed9804afdb7daeafdef009829" ;
  String userid , userMail ;

  @override
  void initState() {
    print(widget.day);
    print(widget.month);
    userid = widget.uid ;
    userMail = widget.umail ;
    refNum="1661${widget.day}${widget.month}$userid" ;
    print(refNum);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.umail);
    print(widget.uid);

    return Material(
      child: Column(
        children: <Widget>[


          SizedBox(height: 20,),

          SizedBox(height: 20,),

          Center(child: FlatButton(onPressed:
              (){

            Navigator.push(context, MaterialPageRoute(builder: (_)=>nn()));
              }, child: Text("check")),),
          Center(
              child: FlatButton(
                  onPressed: () async {
                    String concatData = merchCode +
                        refNum +
                        userid +
                        "PAYATFAWRY" +
                        "25.00" +
                        secureCode ;
                    List<int> bytes = utf8.encode(concatData);
                    String hash = sha256.convert(bytes).toString();
                    print("hash is $hash");

                    var today = new DateTime.now();
                    var expirationDate = today.add(new Duration(hours: 1)).toUtc().millisecondsSinceEpoch;
                    print(expirationDate);


                    // expire date that will be sent to the mobile of user
                    var date = DateTime.now();
                    print('date of now = $date');
                    print('date of nowEpoch = ${date.toUtc().millisecondsSinceEpoch}');
                    var dateplushour = date.add(new Duration(hours: 1));
                    print('date of nowplushour = $dateplushour');
                    print('date of nowEpoch = ${dateplushour.toUtc().millisecondsSinceEpoch}');
                    var expireDate = dateplushour.toUtc().millisecondsSinceEpoch ;


                    var url =
                        'https://atfawry.fawrystaging.com//ECommerceWeb/Fawry/payments/charge';
                    Map<String, dynamic> data = {
                      "merchantCode": merchCode,
                      "merchantRefNum": refNum ,
                      "customerProfileId": userid,
                      "customerMobile": "01553969051",
                      "customerEmail": userMail,
                      "paymentMethod": "PAYATFAWRY",
                      "amount": 25.00,
                      "currencyCode": "EGP",
                      "description": "hello first operation",
                      "paymentExpiry": expireDate,//1561379640000
                      "chargeItems": [
                        {
                          "itemId": "897fa8e81be26df25db592e81c31c",
                          "description": "new description",
                          "price": 20.00,
                          "quantity": 1
                        }
                      ],
                      "signature": hash
                    };
                    final http.Response response = await http.post(
                        Uri.encodeFull(url),
                        headers: {
                          "content-type": "application/json",
                          "accept": "application/json"
                        },
                        body: json.encode(data));
                    String bb = response.body;
                    String rfn = jsonDecode(bb)["referenceNumber"];
                    var Expiretion = jsonDecode(bb)["expirationTime"];
                    print("expiretion time " + "$Expiretion");
                    print("refnum is " + "$rfn");



                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Congratulation(
                                  ExpirationDate: Expiretion,
                                  refNumber: rfn,
                                )));

                    addtranstodb(int refnum,int inty, String date) {
                      Map<String, dynamic> addReservedHour = {

                      };
                      print("upload data");
                    }

                    Firestore.instance.collection('Transaction')
                        .document("damana")
                        .collection("1 june")
                        .document("h1")
                        .setData({
                      'merchrefnum' : refNum,
                      'refnum': rfn,
                      'index': 2,
                      'pay': "not paid",
                    });

                    Firestore.instance.collection('users').document(userid).collection("Transaction")
                        .document(rfn)
                        .setData({
                      'merchrefnum' : refNum,
                      'Expired time' : "${date.add(new Duration(hours: 1))}" ,
                      'hours':'6', // loop for each hour
                      'refnum': rfn,
                      'pay': "not paid",
                      'pgname':"damana",
                      'day': " 1 june "
                    });

                  },
                  child: Text("pay"))),
        ],
      ),
    );
  }
}


class Post {
  final String type;
  final String referenceNumber;
  final String merchantRefNumber;
  final String paymentMethod;
  final String paymentStatus;
  final String statusDescription;
  final double paymentAmount ;
  final int expirationTime ;
  final int statusCode ;
  Post({ this.type,
    this.referenceNumber,
    this.merchantRefNumber,
    this.paymentMethod,
    this.paymentStatus,
    this.statusDescription,
    this.paymentAmount,
    this.expirationTime,
    this.statusCode});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      type: json['type'],
      referenceNumber: json['referenceNumber'],
      merchantRefNumber: json['merchantRefNumber'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      statusDescription: json['statusDescription'],
      paymentAmount: json['paymentAmount'],
      expirationTime: json['expirationTime'],
      statusCode: json['statusCode'],

    );
  }
}

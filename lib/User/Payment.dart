import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:crypt/crypt.dart';
import 'package:playground_user/User/congratulation.dart';
import 'package:playground_user/User/httpget.dart';
import 'package:playground_user/User/playgroundlist.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class Payment extends StatefulWidget {
  static const String id = "Paymemt";
String uid , umail ;
Payment({this.uid,this.umail});
  @override
  _PaymentState createState() => _PaymentState();
}

getuid(){

}

class _PaymentState extends State<Payment> {
  String refNum = "0000033202" ;
  String merchCode = "1PC8/vkn3GzHnfhDcneBrA==";
  String secureCode = "aa8f660ed9804afdb7daeafdef009829" ;
  String userid , userMail ;

  @override
  void initState() {
    userid = widget.uid ;
    userMail = widget.umail ;
    // pgcode + mobil last 2 num + pgsub + month + day
    refNum="16610601" ;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.umail);
    print(widget.uid);

    return Material(
      child: Column(
        children: <Widget>[


          SizedBox(height: 20,),
          Center(child: FlatButton(onPressed: fetchPost, child: Text("getPost")),),
          SizedBox(height: 20,),

          Center(child: FlatButton(onPressed:
              (){

            Navigator.push(context, MaterialPageRoute(builder: (_)=>nn()));
/*
                var  httpClient  =  new  HttpClient();
                var  uri  =  new  Uri.https('atfawry.fawrystaging.com','/ECommerceWeb/Fawry/payments/status?merchantCode=1PC8/vkn3GzHnfhDcneBrA==&merchantRefNumber=0000003202&signature=927d1875d02ef6b1c1c9e694f1c6c56e4469fce9d6d76a07283d24eb32a950c0');
                var  request  =  await httpClient.getUrl(uri);
                var  response  =  await request.close();
                var  responseBody  =  await response.transform(utf8.decoder).join();
                print(responseBody);
                return  responseBody;

*/

            /*        String concatData = merchCode +
                 refNum+
                secureCode;
            List<int> bytes = utf8.encode(concatData);
            String hash = sha256.convert(bytes).toString();
            print("hash is $hash");
            String url ="http://atfawry.fawrystaging.com/ECommerceWeb/Fawry/payments/status?merchantCode=$merchCode&merchantRefNumber=$refNum&signature=$hash";
            print(url);
            http.Response res = await http.get(url);
            print(jsonDecode(res.body));
*/
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
                    var expirationDate = today.add(new Duration(hours: 1));
                    print(expirationDate);
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
                      "paymentExpiry": 2101201819140,
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
                        .setData({ 'refnum': rfn,
                      'index': 2,
                      'pay': "not paid",
                    });

                    Firestore.instance.collection('users').document(userid).collection("Transaction")
                        .document(rfn)
                        .setData({ 'refnum': rfn,
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

/*{"type":"PaymentStatusResponse",
"referenceNumber":"918615055",
"merchantRefNumber":"0000003202",
"paymentAmount":25.0,
"expirationTime":1516554874077,
"paymentMethod":"PAYATFAWRY",
"paymentStatus":"EXPIRED",
"statusCode":200,
"statusDescription":"Operation done successfully",
"accTypesInfo":{}}*/
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
Future<Post> fetchPost() async {
  final response =
  await http.get('https://atfawry.fawrystaging.com/ECommerceWeb/Fawry/payments/status?merchantCode=1PC8/vkn3GzHnfhDcneBrA==&merchantRefNumber=0000003202&signature=927d1875d02ef6b1c1c9e694f1c6c56e4469fce9d6d76a07283d24eb32a950c0');

  if (response.statusCode == 200) {

    return Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

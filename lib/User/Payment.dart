import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:crypt/crypt.dart';
import 'package:playground_user/User/congratulation.dart';
import 'package:playground_user/User/playgroundlist.dart';

class Payment extends StatefulWidget {
  static const String id = "Paymemt";
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: FlatButton(
              onPressed: () async {
                String concatData = "1PC8/vkn3GzHnfhDcneBrA==" +
                    "0000000002" +
                    "iusdiu2135" +
                    "PAYATFAWRY" +
                    "25.00" +
                    "aa8f660ed9804afdb7daeafdef009829";
                List<int> bytes = utf8.encode(concatData);
                String hash = sha256.convert(bytes).toString();
                print("hash is $hash");
                var url =
                    'https://atfawry.fawrystaging.com//ECommerceWeb/Fawry/payments/charge';
                Map<String, dynamic> data = {
                  "merchantCode": "1PC8/vkn3GzHnfhDcneBrA==",
                  "merchantRefNum": "0000000002",
                  "customerProfileId": "iusdiu2135",
                  "customerMobile": "01553969051",
                  "customerEmail": "ph.ahmedmohsin@gmail.com",
                  "paymentMethod": "PAYATFAWRY",
                  "amount": 25.00,
                  "currencyCode": "EGP",
                  "description": "hello first operation",
                  "paymentExpiry": 1516554874077,
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

              },
              child: Text("pay"))),
    );
  }
}

fawryPayRequest() async {}

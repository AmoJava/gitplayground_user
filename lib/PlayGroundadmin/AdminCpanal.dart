import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AdmiinManualReservation.dart';
import 'Pricing.dart';

class pgAdminCpanal extends StatefulWidget {
  int price1,price2,price3;
  String uid;
  String pgname;
  pgAdminCpanal({this.uid, this.pgname,this.price1,this.price2,this.price3});

  @override
  _pgAdminCpanalState createState() => _pgAdminCpanalState(uid);
}

class _pgAdminCpanalState extends State<pgAdminCpanal> {
  _pgAdminCpanalState(this.uid);

  String pgname = "";
  String uid;

  void _fetchdata() {
    DocumentReference ref =
        Firestore.instance.collection("Admins").document(uid);
    ref.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          // pgname = datasnapshot.data['pgname'];
        });
      }
    });
  }

  @override
  void initState() {
    _fetchdata();
    pgname = widget.pgname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
          pgname,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.teal[400],
        child: Center(
          child: Container(
            height: 350,
            width: 250,
            color: Colors.white10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$pgname",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 38,
                ),/*
                FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PgDetails()));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "بيانات الملعب",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                      color: Colors.lightGreen,
                      height: 60,
                      width: 180,
                    )),*/
                SizedBox(
                  height: 8,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AdmiinManualReservation(
                                    pgname: pgname,price1: widget.price1,price2: widget.price2,price3: widget.price3,
                                  )));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "حجز  او غلق ساعة ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                      color: Colors.grey[700],
                      height: 60,
                      width: 180,
                    )),
                SizedBox(
                  height: 8,
                ) /*,
                Text("${widget.price1}"),
                Text("${widget.price2}"),
                Text("${widget.price3}")*/
                ,FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PricingPanal(price1: widget.price1,price2: widget.price2,price3: widget.price3,)));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "الاسعار",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                      color: Colors.grey[700],
                      height: 60,
                      width: 180,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }



}



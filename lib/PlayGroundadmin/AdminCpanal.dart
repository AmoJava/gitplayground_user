import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playground_user/PlayGroundadmin/adminpglist.dart';

import 'AdmiinManualReservation.dart';
import 'Pgdetails.dart';
import 'Pricing.dart';

class pgAdminCpanal extends StatefulWidget {
  String uid;
  String pgname;
  pgAdminCpanal({this.uid, this.pgname});

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
        backgroundColor: Colors.green,
        title: Text(
          pgname,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.lightGreen,
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
                  height: 8,
                ),
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
                    )),
                SizedBox(
                  height: 8,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AdmiinManualReservation(
                                    pgname: pgname,
                                  )));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "حجز  او غلق ساعة ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                      color: Colors.lightGreen,
                      height: 60,
                      width: 180,
                    )),
                SizedBox(
                  height: 8,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => adminpglist()));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "الاسعار",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                      color: Colors.lightGreen,
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

import 'package:flutter/material.dart';

import 'AdmiinManualReservation.dart';
import 'Pgdetails.dart';
import 'Pricing.dart';

class pgAdminCpanal extends StatefulWidget {
  @override
  _pgAdminCpanalState createState() => _pgAdminCpanalState();
}

class _pgAdminCpanalState extends State<pgAdminCpanal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.green,
        child: Center(
          child: Container(
            height: 350,
            width: 250,
            color: Colors.white10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                                    pgname: "ahly",
                                  )));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "حجز ساعة او غلق ساعة ",
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
                          MaterialPageRoute(builder: (_) => PricingPanal()));
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

import 'package:flutter/material.dart';

import 'AdminCpanal.dart';
import 'AdmiinManualReservation.dart';

class PgLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            Container(
              height: 200,
              color: Colors.white10,
              width: 200,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    pgAdminCpanal() /*AdmiinManualReservation(
                      pgname: "ahly",
                    )*/
                                ));
                      },
                      child: Text(
                        "login",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "contact with el3bkora.com",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

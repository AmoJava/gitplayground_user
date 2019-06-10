import 'package:flutter/material.dart';
import 'package:playground_user/User/playgroundlist.dart';

import 'Tickets.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "أهلا أحمد",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayGroundList()));
                },
                child: Container(
                    color: Colors.lightGreen,
                    height: 120,
                    child: Center(
                        child: Text(
                      "احجز ملعب",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
            SizedBox(
              height: 5,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tickets()));
                },
                child: Container(
                    color: Colors.indigoAccent,
                    height: 120,
                    child: Center(
                        child: Text(
                      "تزاكر حجوزاتك",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
          ],
        ),
      ),
    );
  }
}

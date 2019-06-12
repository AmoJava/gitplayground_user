import 'package:flutter/material.dart';
import 'package:playground_user/User/Fawry.dart';

class Confirmation extends StatefulWidget {
  static const String id = "Confirmation";
  var selecteditems;

  Confirmation(this.selecteditems);
  @override
  _ConfirmationState createState() => _ConfirmationState(selecteditems);
}

class _ConfirmationState extends State<Confirmation> {
  var selecteditems;

  _ConfirmationState(this.selecteditems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Text(
                  " لقد قمت بحجز الساعه   $selecteditems ",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                )),
            Text(
              "قيمه الحجز 120 جنيها ",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.indigo.shade300,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(onPressed: () {}, child: Text("رجوع")),
                FlatButton(
                    onPressed: () {
                      // صفحه فوري
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Fawry()));
                    },
                    child: Text("الدفع"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class payatfawry extends StatefulWidget {
  @override
  _payatfawryState createState() => _payatfawryState();
}

class _payatfawryState extends State<payatfawry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.lightGreen.shade300,
                child: Container(height: 120,child: Text("طلبك "),),)
            ],
          ),
        ),
      ),
    );
  }
}


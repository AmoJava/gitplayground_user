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
                child: Container(
                  width: 400,
                  height: 120,
                  child: Column(
                    children: <Widget>[
                      Text("Ref num   0232563253",style:TextStyle(fontSize: 20 , color: Colors.white),),
                      Text("Expire date is  3232",style:TextStyle(fontSize: 20 , color: Colors.white))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

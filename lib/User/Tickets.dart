import 'package:flutter/material.dart';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('لا توجد لديك تذاكـر حاليا ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
            Text(' :( ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'Login.dart';

class Wellcome extends StatefulWidget {
  @override
  _WellcomeState createState() => _WellcomeState();
}

class _WellcomeState extends State<Wellcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(onPressed: ()=>Navigator.pushNamed(context, Login.id),child: Text("yarab"),),
      ),

    );
  }
}


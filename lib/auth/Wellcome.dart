import 'dart:async';

import 'package:flutter/material.dart';

import 'Login.dart';

class spalsh_screen extends StatefulWidget {
  @override
  _spalsh_screenState createState() => _spalsh_screenState();
}

class _spalsh_screenState extends State<spalsh_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor:Colors.yellow.shade500,
      body: Container(

        decoration: BoxDecoration(color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                    "assets/Splash.png"
                ))),
      ),
    );
  }
}

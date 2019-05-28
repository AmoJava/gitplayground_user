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
    Timer(Duration(seconds: 10),()=>Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.yellow.shade500,
      body: Center(child:
      Image.asset("assets/alex-462576-unsplash.jpg",height: 1500,),),
    );
  }
}



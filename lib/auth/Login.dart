import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:playground_user/User/UserProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget {
  static const String id = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading =false ;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  FacebookLogin fblogin = new FacebookLogin();

  /*Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gsa = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gsa.accessToken,
      idToken: gsa.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("username:${user.displayName}");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserProfile()));

    return user;
  }*/

  final TextStyle textstyle =
      TextStyle(color: Colors.black87, fontWeight: FontWeight.bold);
  final InputDecoration decoration = InputDecoration(
    border: OutlineInputBorder(),
  );

  Future<bool> _onBackPressed() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("do you really want to exit the app"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text("yes"),
                onPressed: () => exit(0),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight, repeat: ImageRepeat.repeatX,
                image: AssetImage("assets/intro.gif",)
                //  "https://media.giphy.com/media/ckXTbeFGygcMiuh8pr/giphy.gif")
                , /*colorFilter:ColorFilter.linearToSrgbGamma() */)),
          child: Container(width: double.infinity,
            child: Column(
              children: <Widget>[
                Spacer(),
Stack(children: <Widget>[
  Container(
    width: 250,
    color: Colors.white54,
    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        SizedBox(
          height: 10,
        ),
        Text(
          "Login by ",
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w900,
              color: Colors.white),
        ),
        SizedBox(
          height: 3,
        )
        ,MaterialButton(
          onPressed: handleSignin,
          color: Colors.red,
          minWidth: 160,
          child: Text(
            'gmail',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text('or'),
        SizedBox(
          height: 2,
        ),


        MaterialButton(
          minWidth: 160,
          onPressed: () {
            fblogin.logInWithReadPermissions(
                ['email', 'public_profile']).then((result) {
              switch (result.status) {
                case FacebookLoginStatus.loggedIn:
                  AuthCredential credential =
                  FacebookAuthProvider.getCredential(
                      accessToken: result.accessToken.token);

                  FirebaseAuth.instance
                      .signInWithCredential(credential);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfile()));

                  FirebaseAuth.instance
                      .signInWithCredential(credential);
                  // TODO: Handle this case.
                  break;
                case FacebookLoginStatus.cancelledByUser:
                // TODO: Handle this case.
                  break;
                case FacebookLoginStatus.error:
                // TODO: Handle this case.
                  break;
              }
            }).catchError((e) {
              print(e);
            });
          },
          color: Colors.blue,
          child: Text(
            'Facebook',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10,
        ),

      ],
    ),
  ),
  Visibility(visible: loading,child: Padding(
    padding: EdgeInsets.only(left: 100,top: 80),
    child: CircularProgressIndicator(backgroundColor: Colors.purpleAccent,strokeWidth: 10,),
  ),)
],),
                SizedBox(height: 20,),
                /*Container(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    height: 20,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RootPage(auth: new Auth())));
                    },
                    color: Colors.grey,
                    minWidth: 100,
                    child: Text(
                      ' Admins',
                      style: textstyle,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleSignin() async {

    setState(() {
      loading=true ;
    });

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    print("signed in " + user.displayName);

    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance.collection("users").document(user.uid).setData({
          "id": user.uid,
          "username": user.displayName,
          "profilepic": user.photoUrl
        });
      } else {}

      Fluttertoast.showToast(msg: "Wellcome ${user.displayName}");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserProfile()));
    } else {
      Fluttertoast.showToast(msg: "Login failed :(");
    }
  }
}


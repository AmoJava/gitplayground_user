import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:playground_user/PlayGroundadmin/PgAdminLogin.dart';
import 'package:playground_user/User/UserProfile.dart';
import 'package:playground_user/User/playgroundlist.dart';
import 'package:playground_user/PlayGroundadmin/AdmiinManualReservation.dart';
import 'Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget {
  static const String id = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  FacebookLogin fblogin = new FacebookLogin();

  Future<FirebaseUser> _signIn() async {
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
  }

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
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    "https://media.giphy.com/media/l3vQWvLXw74jemGoU/giphy.gif",
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("log in with ,, ", style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),),
                  SizedBox(
                    height: 3,
                  ),
                  MaterialButton(
                    onPressed: handleSignin,
                    color: Colors.red,
                    minWidth: 160,
                    child: Text(
                      'gmail',
                      style: textstyle,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text('or'),
                  SizedBox(
                    height: 2,
                  ),
                  /*
                  FlatButton(
                      onPressed: () {
                        _signIn()
                            .then((FirebaseUser user) => print(user))
                            .catchError((e) => print(e));

                      },
                      child: Container(
                        color: Colors.red,
                        child: Text(
                          'facebook',
                          style: textstyle,
                        ),
                      )),*/
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
                      style: textstyle,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    height: 20,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PgLogin()));
                    },
                    color: Colors.green,
                    minWidth: 160,
                    child: Text(
                      'playGround admin',
                      style: textstyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleSignin() async {
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

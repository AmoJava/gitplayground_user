import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'Reservationpage.dart';

class payatfawry extends StatefulWidget {
  String userid;
  payatfawry({this.userid});
  @override
  _payatfawryState createState() => _payatfawryState();
}

class _payatfawryState extends State<payatfawry> {
  @override
  Widget build(BuildContext context) {
    print(widget.userid);
    return Scaffold(
        appBar: AppBar(
          title: Text("ادفع في فوري"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Container(
          color: Colors.green,
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white10,
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document('${widget.userid}')
                        .collection('Transaction')
                        .orderBy('refnum', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Text(
                          " Loading transactions .... ",
                          style: TextStyle(fontSize: 25),
                        ));
                      }
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot pgSnapshot =
                                snapshot.data.documents[index];

                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                  onTap: () {


                                    EasyDialog(
                                        title: Text(
                                          "Confirm FawryPay Operation",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textScaleFactor: 1.2,
                                        ),
                                        description: Text(
                                          "This is a basic dialog. Easy Dialog helpsyou easily create basic or custom dialogs.",
                                          textScaleFactor: 1.1,
                                          textAlign: TextAlign.center,
                                        ),
                                        topImage: NetworkImage(
                                            "https://raw.githubusercontent.com/ricardonior29/easy_dialog/master/example/assets/topImageblack.png"),
                                        height: 240,
                                        contentList: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              new FlatButton(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                textColor: Colors.lightBlue,
                                                onPressed: () {
                                                  Navigator.of(context).pop();

                                                },
                                                child: new Text(
                                                  "Accept",
                                                  textScaleFactor: 1.2,
                                                ),
                                              ),
                                              new FlatButton(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                textColor: Colors.lightBlue,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: new Text(
                                                  "Cancel",
                                                  textScaleFactor: 1.2,
                                                ),
                                              ),
                                            ],
                                          )
                                        ]).show(context);
                                  },
                                  child: Card(
                                    elevation: 2,
                                    color: Colors.transparent,
                                    child: Center(
                                        child: Container(
                                            height: 180,
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${pgSnapshot["refnum"]}",
                                                    style: TextStyle(
                                                        fontSize: 38,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),Text(
                                                  " will expire in ${pgSnapshot["Expired time"]}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w300),
                                                ),
                                                Text(
                                                  "${pgSnapshot["hours"]}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w300),
                                                ),
                                                Text(
                                                  "${pgSnapshot["day"]}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Text(
                                                  "${pgSnapshot["pgname"]}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ))),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              )),
        ));
  }
}

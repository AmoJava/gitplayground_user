import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playground_user/%D9%8DService/getDates.dart';
import 'package:queries/collections.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'dart:async';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:playground_user/User/ConfirmationPage.dart';

import 'package:playground_user/ٍService/addDataTofirestore.dart';

class PgAdmin extends StatefulWidget {
  String pgname;

  PgAdmin({this.pgname});

  @override
  _PgAdminState createState() => _PgAdminState(pgname);
}

class _PgAdminState extends State<PgAdmin> {
  bool isSelected;
  var reservationColor;
  static List tapedItems;
  static List selectedItems;
  String hourStateColor;

  @override
  void initState() {
    tapedItems = [];
    selectedItems = [];
  }

  var _date = getDateofdaywithoutHH();

  _PgAdminState(this.pgname);

  String pgname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("mal3ab$pgname "),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Carousel(
                  axis: Axis.horizontal,
                  indicatorType: "dot",
                  showIndicator: true,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  type: "simple",
                  children: [
                    Image.asset(
                      'assets/pg1.jpg',
                      fit: BoxFit.fill,
                    ),
                    Image.asset('assets/pg2.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg3.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg4.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg5.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg6.jpg', fit: BoxFit.fill),
                  ]),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${_date.toString()}",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                  /*new RaisedButton(
                    child: Text("selectTime"),
                    onPressed: (){
                      _selectDate(context);
                    },
                  ),*/
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        //  _selectDate(context);

                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2019, 6, 7),
                            maxTime: DateTime(2019, 7, 15), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            var dateFormat =
                                DateFormat('dd MMM yyyy ').format(date);

                            _date = dateFormat;
                          });
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.ar);
                      })
                ],
              )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection("pgs")
                          .document("damana")
                          .collection('$_date')
                          .orderBy('index', descending: false)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: const Text('Loading events...'));
                        } else if (snapshot.data.documents.length < 24) {
                          for (int x = 0; x < 24; x++) {
                            addReservationtodb(x, '$_date');
                          }

                          return Center(child: const Text('creating data...'));
                        } else
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6),
                            shrinkWrap: true,
                            itemCount: 24,
                            itemBuilder: (BuildContext context, int index) {
                              int numby = snapshot.data.documents.length;

                              /* var reservation_bool =
                                  snapshot.data.documents[index]['isReserved'];*/

                              var reservation_color =
                                  snapshot.data.documents[index]['color'];

                              hourStateColor = reservation_color;

                              switch (hourStateColor) {
                                case "green":
                                  {
                                    reservationColor = Colors.lightGreenAccent;
                                  }
                                  break;

                                case "red":
                                  {
                                    reservationColor = Colors.redAccent;
                                  }
                                  break;

                                case "yellow":
                                  {
                                    reservationColor = Colors.yellowAccent;
                                  }
                                  break;

                                default:
                                  {
                                    reservationColor = Colors.green;
                                  }
                                  break;
                              }

                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => NetworkGiffyDialog(
                                              image: Image.network(
                                                "https://media.giphy.com/media/1BGQuBhcLua8DWuE7h/giphy.gif",
                                                fit: BoxFit.fitHeight,
                                              ),
                                              title: Text('رساله تأكيديه',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              description: Text(
                                                  "هل تريد تأكيد غلق هذه الساعه امام المستخدمين"),
                                              onOkButtonPressed: () {
                                                Firestore.instance
                                                    .collection('pgs')
                                                    .document("damana")
                                                    .collection("$_date")
                                                    .document("h$index")
                                                    .updateData({
                                                  'color': 'red',
                                                  'reservedby': 'admin'
                                                });

                                                print("done from h$index + "
                                                    " $_date");
                                                Navigator.of(context).pop();
                                              }));
                                    },
                                    onLongPress: () {
                                      Firestore.instance
                                          .collection('pgs')
                                          .document("damana")
                                          .collection("$_date")
                                          .document("h$index")
                                          .updateData({
                                        'color': 'red',
                                        'reservedby': 'admin'
                                      });
                                      Navigator.pop(context);
                                      print("done from h$index + " " $_date");
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: reservationColor,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          "$index",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                      })),
              SizedBox(
                height: 15,
              ), /*
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Confirmation()));
                  },
                  child: Text(
                    "تأكيد الحجز",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ))*/
            ],
          ),
        ),
      ),
    );
  }
}

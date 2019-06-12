import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:playground_user/%D9%8DService/addDataTofirestore.dart';
import 'package:queries/collections.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'dart:async';

import 'package:playground_user/User/ConfirmationPage.dart';

class ReservationPage extends StatefulWidget {
  static const String id = "reservationPage";
  String pgname;
  ReservationPage({this.pgname});
  @override
  _ReservationPageState createState() => _ReservationPageState(pgname);
}

class _ReservationPageState extends State<ReservationPage> {
  _ReservationPageState(this.pgname);

  String pgname;
  var reservationColor;
  String hourStateColor;
  static List tapedItems;
  static List selectedItems;

  var date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    tapedItems = [];
    selectedItems = [];

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020));
    if (picked != null && picked != date) {
      print("date selcted:${date.toString()}");
      setState(() {
        date = picked;
      });
    }
  }

  @override
  void initState() {
    tapedItems = [];
    selectedItems = [];
  }

  @override
  Widget build(BuildContext context) {
    var selectionColor = Colors.transparent;
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
                        DateFormat('dd MMM yyyy ').format(date),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
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
                          .collection(DateFormat('dd MMM yyyy').format(date))
                          .orderBy('index', descending: false)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        bool selecteditem = false;
                        if (!snapshot.hasData) {
                          return Center(child: const Text('Loading events...'));
                        } else if (snapshot.data.documents.length < 24) {
                          for (int x = 0; x < 24; x++) {
                            addReservationtodb(
                                x, DateFormat('dd MMM yyyy').format(date));
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
                              var reservation_color =
                              snapshot.data.documents[index]['color'];
                              //bool selectionbool = false;

                              switch (reservation_color) {
                                case "green":
                                  {
                                    reservationColor = Colors.lightGreen;
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
                              }

                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: InkWell(
                                    child: Container(
                                      height: 70,
                                      color: selectionColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: reservationColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Text(
                                              "$index",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print("color changed");
                                      selectionColor = Colors.pink;
                                      setState(() {
                                        selectionColor = Colors.pink;
                                        print("color changed from set state ");
                                      });
                                      print(selectionColor);
                                    }
/*                                    onTap: () {
                                      switch (reservation_color) {
                                        case 'green':
                                          {
                                            setState(() {
                                              selectionColor = Colors.pink;
                                            });
                                            print(index);
                                            tapedItems.add(index);
                                            selectedItems =
                                                Collection(tapedItems)
                                                    .distinct()
                                                    .toList();
                                            print(tapedItems);
                                            print(selectedItems.toList());

                                            var snack = SnackBar(
                                                duration: Duration(seconds: 2),
                                                backgroundColor: Colors.blue,
                                                content: Text(
                                                  "لقد قمت بتحديد الساعه ${selectedItems
                                                      .toString()} لالغاء التحديد انقر مرتين علي الساعه المراد الغاء تحديدها ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ));
                                            Scaffold.of(context).showSnackBar(
                                                snack);
                                          }
                                          break;
                                        case 'red':
                                          {
                                            setState(() {
                                              var snack = SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "هذه الساعه محجوزه مسبقا ",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ));
                                              Scaffold.of(context).showSnackBar(
                                                  snack);
                                            });
                                          }
                                          break;
                                        case 'yellow':
                                          {
                                            setState(() {
                                              var snack = SnackBar(
                                                  backgroundColor: Colors
                                                      .yellow,
                                                  content: Text(
                                                    "هذه الساعه محجوزه مؤقتا بانتظار الدفع ",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ));
                                              Scaffold.of(context).showSnackBar(
                                                  snack);
                                            });
                                          }
                                          break;
                                      }
                                    }*/
                                    ,
                                    onDoubleTap: () {
                                      if (reservation_color == 'green') {
                                        tapedItems.remove(index);
                                        selectedItems.remove(index);

                                        print(selectedItems);
                                        setState(() {
                                          if (selectedItems.isEmpty) {
                                            tapedItems = [];
                                          }
                                        });
                                        var snack = SnackBar(
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.blue,
                                            content: Text(
                                              selectedItems.isEmpty
                                                  ? "لم تحدد اي ساعه"
                                                  : "you have select ${selectedItems
                                                  .toString()} ",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ));
                                        Scaffold.of(context)
                                            .showSnackBar(snack);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                      })),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("سعر الساعة 120"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                    color: Colors.yellow,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Confirmation(selectedItems)));
                    },
                    child: Text(
                      "تأكيد الحجز",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
class HourElement extends StatefulWidget {
  var reservationColor;
  String hourStateColor;
  HourElement({this.num, this.isNotReservedBefore});
  int num;
  bool isNotReservedBefore;

  @override
  _HourElementState createState() => _HourElementState(
      hourIndex: num, isNotReservedBefore: isNotReservedBefore);
}

class _HourElementState extends State<HourElement> {
  int hourIndex;
  _HourElementState({this.hourIndex, this.isNotReservedBefore});

  bool isNotReservedBefore;
  bool isSelected;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(
        child: GestureDetector(


          child: Container(
            height: 40,
            decoration:
                BoxDecoration(color: reservationColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                "$hourIndex",
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

*/

/*showDialog(
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
                                                    .collection(DateFormat('dd MMM yyyy').format(date))
                                                    .document("h$index")
                                                    .updateData({
                                                  'color': 'red',
                                                  'reservedby': 'admin'
                                                });

                                                print("done from h$index + "
                                                    " ${DateFormat('dd MMM yyyy').format(date)}");
                                                Navigator.of(context).pop();
                                              }));*/

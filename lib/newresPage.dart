import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queries/collections.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'dart:async';

import 'ConfirmationPage.dart';

class MewresPage extends StatefulWidget {
  static const String id = "reservationPage";
  String pgname;

  MewresPage({this.pgname});

  @override
  _MewresPageState createState() => _MewresPageState(pgname);
}

class _MewresPageState extends State<MewresPage> {
  bool isNotReservedBefore;
  bool isSelected;
  var reservationColor;
  static List tapedItems;
  static List selectedItems;

  @override
  void initState() {
    tapedItems = [];
    selectedItems = [];

    if (isNotReservedBefore == true) {
      reservationColor = Colors.green;
    } else
      reservationColor = Colors.red;
  }

  DateTime _date = new DateTime.now();

  //TimeOfDay _time=new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020));
    if (picked != null && picked != _date) {
      print("date selcted:${_date.toString()}");
      setState(() {
        _date = picked;
      });
    }
  }

  _MewresPageState(this.pgname);

  String pgname;

  int indexX;

  var mycolor = Colors.white;

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
                        _selectDate(context);
                      })
                ],
              )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  color: Colors.white,
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection("pgs")
                          .document("ahly")
                          .collection('1 june')
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: const Text('Loading events...'));
                        }

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6),
                          shrinkWrap: true,
                          itemCount: 24,
                          itemBuilder: (BuildContext context, int index) {
                            int numby = snapshot.data.documents.length;
                            var reservation_bool =
                                snapshot.data.documents[index]['isReserved'];
                            /*if (snapshot.hasData){
                                reservation_bool ;
                                }else
                                  reservation_bool=true ;
                                      for (int i=0 ; i <25 ; i++)*/
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (isNotReservedBefore == true) {
                                      print(index);
                                      tapedItems.add(index);
                                      selectedItems = Collection(tapedItems)
                                          .distinct()
                                          .toList();
                                      print(tapedItems);
                                      print(selectedItems.toList());

                                      var snack = SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.blue,
                                          content: Text(
                                            "لقد قمت بتحديد الساعه ${selectedItems.toString()} لالغاء التحديد انقر مرتين علي الساعه المراد الغاء تحديدها ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ));
                                      Scaffold.of(context).showSnackBar(snack);
                                      //reservationColor=Colors.green;
                                      //isNotReservedBefore=true ;

                                    }

                                    switch (isNotReservedBefore) {
                                      case true:
                                        {
                                          setState(() {
                                            reservationColor = Colors.blue;
                                            isSelected = true;
                                          });
                                        }
                                        break;
                                      case false:
                                        {
                                          setState(() {
                                            var snack = SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  "هذه الساعه محجوزه مسبقا ",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ));
                                            Scaffold.of(context)
                                                .showSnackBar(snack);
                                            //reservationColor=Colors.green;
                                            //isNotReservedBefore=true ;
                                          });
                                        }
                                        break;
                                    }
                                  },
                                  onDoubleTap: () {
                                    if (isNotReservedBefore == true) {
                                      tapedItems.remove(index);
                                      selectedItems.remove(index);
                                      //print(tapedItems);
                                      //print(Collection(tapedItems).distinct().toList());
                                      print(selectedItems);
                                      setState(() {
                                        reservationColor = Colors.green;
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
                                                : "you have select ${selectedItems.toString()} ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ));
                                      Scaffold.of(context).showSnackBar(snack);
                                    }
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
                                            color: Colors.white, fontSize: 15),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

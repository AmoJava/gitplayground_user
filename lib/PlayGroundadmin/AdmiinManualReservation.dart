import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:giffy_dialog/giffy_dialog.dart';

class AdmiinManualReservation extends StatefulWidget {
  int price1, price2, price3;
  String pgname;

  AdmiinManualReservation({this.pgname, this.price1, this.price2, this.price3});

  @override
  _AdmiinManualReservationState createState() =>
      _AdmiinManualReservationState(pgname);
}

class _AdmiinManualReservationState extends State<AdmiinManualReservation> {
  bool isSelected;
int byuserssum=0 ;
  var reservationColor;
  String hourStateColor;
  String textofindex;

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
  // ignore: must_call_super
  void initState() {
    tapedItems = [];
    selectedItems = [];
  }

  _AdmiinManualReservationState(this.pgname);

  String pgname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("$pgname"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    intl.DateFormat('dd MMM yyyy').format(date),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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
                  color: Colors.white,
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection("pgs")
                          .document("$pgname")
                          .collection(intl.DateFormat('dd MMM yyyy').format(date))
                          .orderBy('index', descending: false)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: const Text('Loading events...'));
                        } else if (snapshot.data.documents.length < 24) {
                          for (int x = 0; x < 4; x++) {
                            addReservationtodb(
                                date: intl.DateFormat('dd MMM yyyy').format(date),
                                inty: x,
                                price: widget.price1);
                          }
                          ;
                          for (int x = 4; x < 17; x++) {
                            addReservationtodb(
                                date: intl.DateFormat('dd MMM yyyy').format(date),
                                inty: x,
                                price: widget.price2);
                          }
                          ;
                          for (int x = 17; x < 24; x++) {
                            addReservationtodb(
                                date: intl.DateFormat('dd MMM yyyy').format(date),
                                inty: x,
                                price: widget.price3);
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
                              /* var reservation_bool =
                                  snapshot.data.documents[index]['isReserved'];*/


                              var reservation_color =
                                  snapshot.data.documents[index]['color'];
                              var reserved_by =
                                  snapshot.data.documents[index]['reservedBy'];
                              var price =
                              snapshot.data.documents[index]['price'];



                              hourStateColor = reservation_color;

                              switch (hourStateColor) {
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

                                default:
                                  {
                                    reservationColor = Colors.green;
                                  }
                                  break;
                              }

                              switch (index) {
                                case 0:
                                  {
                                    textofindex = "12 ص";
                                  }
                                  break;

                                case 1:
                                  {
                                    textofindex = "1 ص";
                                  }
                                  break;

                                case 2:
                                  {
                                    textofindex = "2 ص";
                                  }
                                  break;
                                case 3:
                                  {
                                    textofindex = "3 ص";
                                  }
                                  break;
                                case 4:
                                  {
                                    textofindex = "4 ص";
                                  }
                                  break;
                                case 5:
                                  {
                                    textofindex = "5 ص";
                                  }
                                  break;
                                case 6:
                                  {
                                    textofindex = "6 ص";
                                  }
                                  break;
                                case 7:
                                  {
                                    textofindex = "7 ص";
                                  }
                                  break;
                                case 8:
                                  {
                                    textofindex = "8 ص";
                                  }
                                  break;
                                case 9:
                                  {
                                    textofindex = "9 ص";
                                  }
                                  break;
                                case 10:
                                  {
                                    textofindex = "10 ص";
                                  }
                                  break;
                                case 11:
                                  {
                                    textofindex = "11 ص";
                                  }
                                  break;
                                case 12:
                                  {
                                    textofindex = "12 ظ ";
                                  }
                                  break;
                                case 13:
                                  {
                                    textofindex = "1 ظ";
                                  }
                                  break;
                                case 14:
                                  {
                                    textofindex = "2 ظ";
                                  }
                                  break;
                                case 15:
                                  {
                                    textofindex = "3 م";
                                  }
                                  break;
                                case 16:
                                  {
                                    textofindex = "4 م";
                                  }
                                  break;
                                case 17:
                                  {
                                    textofindex = "5 م";
                                  }
                                  break;
                                case 18:
                                  {
                                    textofindex = "6 م";
                                  }
                                  break;
                                case 19:
                                  {
                                    textofindex = "7 م";
                                  }
                                  break;
                                case 20:
                                  {
                                    textofindex = "8 م";
                                  }
                                  break;
                                case 21:
                                  {
                                    textofindex = "9 م";
                                  }
                                  break;
                                case 22:
                                  {
                                    textofindex = "10 م";
                                  }
                                  break;
                                case 23:
                                  {
                                    textofindex = "11 م";
                                  }
                                  break;
                              }

                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (reservation_color == "red") {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return StreamBuilder(
                                                  stream: Firestore.instance
                                                      .collection("pgs")
                                                      .document("$pgname")
                                                      .collection(intl.DateFormat(
                                                              'dd MMM yyyy')
                                                          .format(date))
                                                      .orderBy('index',
                                                          descending: false)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          snapshot) {
                                                    return SizedBox(
                                                      height: 80,
                                                      child: AlertDialog(
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        title: Text(
                                                            "بيانات الساعة المحجوزة"),
                                                        content: SizedBox(
                                                          height: 180,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                  "تم حجزها بواسطه "),
                                                              Text(
                                                                reserved_by ==
                                                                        "admin"
                                                                    ? "admin"
                                                                    : '${snapshot.data.documents[index]["mobile"]}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .pink,
                                                                    fontSize:
                                                                        15),
                                                              ), //snapshot.data.documents[index]["mobile"]==null?"admin":snapshot.data.documents[index]["mobile"].toString()
                                                              Text(
                                                                  "المبلغ المدفوع "),
                                                              Text(snapshot
                                                                  .data
                                                                  .documents[
                                                                          index]
                                                                      ["price"]
                                                                  .toString()),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        color: Colors
                                                                            .grey,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Text(
                                                                              "X",
                                                                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {

                                                                            if (reserved_by == "admin") {
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
                                                                                          "هل تريد اعاده تشغيل هذه الساعه امام المستخدمين",textAlign: TextAlign.center,),
                                                                                      onOkButtonPressed: () {
                                                                                        Firestore.instance
                                                                                            .collection('pgs')
                                                                                            .document("$pgname")
                                                                                            .collection(intl.DateFormat(
                                                                                            'dd MMM yyyy')
                                                                                            .format(date))
                                                                                            .document("h$index")
                                                                                            .updateData({
                                                                                          'color': 'green',
                                                                                          'reservedBy': ''
                                                                                        });

                                                                                        Navigator.of(context).pop();
                                                                                        Navigator.of(context).pop();
                                                                                        
                                                                                      }));
                                                                            }


                                                                          },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5.0),
                                                                          child:
                                                                              Text(
                                                                            "اعاده تشغيل الساعه",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        color: Colors
                                                                            .green,
                                                                      )),
                                                                ],
                                                              )

                                                              //Text("الموبايل:0101520")
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            });
                                      }

                                      if (reservation_color == "green") {
                                        showDialog(
                                            context: context,
                                            builder: (_) => NetworkGiffyDialog(cornerRadius: 30,
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
                                                    "هل تريد تأكيد غلق هذه الساعه امام المستخدمين",textAlign: TextAlign.center,),
                                                onOkButtonPressed: () {
                                                  Firestore.instance
                                                      .collection('pgs')
                                                      .document("$pgname")
                                                      .collection(intl.DateFormat(
                                                              'dd MMM yyyy')
                                                          .format(date))
                                                      .document("h$index")
                                                      .updateData({
                                                    'color': 'red',
                                                    'reservedBy': 'admin'
                                                  });

                                                  Navigator.of(context).pop();
                                                }));
                                      }
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: reservationColor,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          "$textofindex",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
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

              /*Directionality(textDirection: TextDirection.rtl,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(4, 8, 5, 8),
                      child: Container(width: MediaQuery.of(context).size.width*.75,child: Text("عدد الساعات المحجوزه بواسطه المستخدمين",textAlign: TextAlign.center,)),
                    ),
                    Text("5",style: TextStyle(fontSize: 20),)
                  ],
                ),
              )*/

            ],
          ),
        ),
      ),
    );

  }

  addReservationtodb({int inty, String date, int price}) {
    Map<String, dynamic> addReservedHour = {
      'color': 'green',
      'index': inty,
      'price': price,
      'merchrefnum': "",
      //'userName': "amo",
      //'userID': "Ghgffgfg211fgfgfgfgfgfg",
      //'userEmail': "ph.ahmedmohsin@gmai.com",
      //"userProfilePic":"httppp/gjgjhgjhgjhg",
      //'dateOfReservation': "${getDateofnow()}",
      //'isReserved': true,
      //"paymentConfirmed" : true ,
      //"paymentMethod": "visa",
      //"operationNumber": 2121512121212442
    };

    Firestore.instance
        .collection('pgs')
        .document("$pgname")
        .collection("$date")
        .document("h$inty")
        .setData(addReservedHour);
    print("upload done +h$inty +$price");
  }
}

/*                                    onLongPress: () {
                                      Firestore.instance
                                          .collection('pgs')
                                          .document("$pgname")
                                          .collection(
                                          DateFormat('dd MMM yyyy').format(
                                              date))
                                          .document("h$index")
                                          .updateData({
                                        'color': 'red',
                                        'reservedby': 'admin'
                                      });
                                      Navigator.pop(context);
                                      print(
                                          "done from h$index + " " ${DateFormat(
                                              'dd MMM yyyy').format(date)}");
                                    }*/

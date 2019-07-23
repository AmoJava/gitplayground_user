import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playground_user/User/Payment.dart';
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
  String pic1;
  String textofindex;
  String merchCode = "2CoQMvyQiz8v2XJswGNsTw==";
  String secureCode = "53c6b354a3934f2697a7078394944f89";
  String userId;
  String usermail;
  String pgname;
  var reservationColor;
  String hourStateColor;
  static List tapedItems;
  static List selectedItems;
  int month, day;
  String merchantRefNum;
  Response response;
  Dio dio = new Dio();
  var dateofnowepoch;
  var expiredate = 00;
  int price1, price2, price3;
  String location;
  _fetchData(String url) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(url);
    print(response);
    return response;
  }

  Future<void> getUserId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    setState(() {
      userId = user.uid;
      usermail = user.email;
    });
  }

  var date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    tapedItems = [];
    selectedItems = [];

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(Duration(days: 14)));
    if (picked != null && picked != date) {
      print("date selcted:${date.toString()}");
      setState(() {
        date = picked;
        month = date.month;
        day = date.day;
        print(day);
        print(month);
      });
    }
  }

  @override
  void initState() {
    _loadprice(pgname);
    tapedItems = [];
    selectedItems = [];
    getUserId();
    dateofnowepoch = date.toUtc().millisecondsSinceEpoch;
  }

  void _loadprice(String pgname) {
    DocumentReference ref =
        Firestore.instance.collection("pgs").document(pgname);
    ref.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          location = datasnapshot.data['address'];
          price1 = datasnapshot.data['price1'];
          price2 = datasnapshot.data['price2'];
          price3 = datasnapshot.data['price3'];
          pic1 = datasnapshot.data['pic1'];
          print(price1);
          print(price2);
          print(price3);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectionColor = Colors.transparent;
    var st = Firestore.instance
        .collection("pgs")
        .document("$pgname")
        .collection(DateFormat('dd MMM yyyy').format(date))
        .orderBy('index', descending: false)
        .snapshots();
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
                    pic1 != null
                        ? Image.network(
                            pic1,
                            fit: BoxFit.fill,
                          )
                        : Image.asset("assets/pg3.jpg"),
                    pic1 != null
                        ? Image.network(pic1)
                        : Image.asset("assets/pg3.jpg"),
                    pic1 != null
                        ? Image.network(pic1)
                        : Image.asset("assets/pg3.jpg"),

                    Image.asset('assets/pg3.jpg', fit: BoxFit.fill),
                    //Image.network(pic1),
                    Image.asset('assets/pg5.jpg', fit: BoxFit.fill),
                    //Image.network(pic1),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    "$location",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20),
                  )),
                  Icon(
                    Icons.location_on,
                    size: 35,
                    color: Colors.green,
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "01553969051",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.call,
                    size: 35,
                    color: Colors.green,
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "5*5",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.green,
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "من الساعه 6 مساء حتي الساعه الرابعه صباحا$price1 جنيها و من الساعه الرابعه صباحا حتي السادسه مساء $price2 جنيه عرض لفتره محدوده",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.monetization_on,
                    size: 35,
                    color: Colors.green,
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DateFormat('dd MMM yyyy ').format(date),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
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
                      stream: st,
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: const Text('Loading events...'));
                        } else if (snapshot.data.documents.length < 24) {
                          for (int x = 0; x < 4; x++) {
                            adduReservationtodb(
                                date: DateFormat('dd MMM yyyy').format(date),
                                inty: x,
                                price: price1);
                          }
                          ;
                          for (int x = 4; x < 17; x++) {
                            adduReservationtodb(
                                date: DateFormat('dd MMM yyyy').format(date),
                                inty: x,
                                price: price2);
                          }
                          ;
                          for (int x = 17; x < 24; x++) {
                            adduReservationtodb(
                                date: DateFormat('dd MMM yyyy').format(date),
                                inty: x,
                                price: price3);
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

                              bool loading = false;

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

                              if (reservation_color == "yellow") {
                                expiredate = snapshot.data.documents[index]
                                    ['Expired time'];

                                if (expiredate > dateofnowepoch) {
                                  print(" $index still under the time");
                                } else {
                                  merchantRefNum = snapshot
                                      .data.documents[index]['merchrefnum'];

                                  var reservation_uid = snapshot
                                      .data.documents[index]['reservedBy'];

                                  var refnum =
                                      snapshot.data.documents[index]['refnum'];

                                  print(merchantRefNum);
                                  String conc =
                                      merchCode + merchantRefNum + secureCode;
                                  List<int> bytess = utf8.encode(conc);
                                  String hash =
                                      sha256.convert(bytess).toString();
                                  //print("hash is $hash");
                                  String url =
                                      "https://www.atfawry.com//ECommerceWeb/Fawry/payments/status?merchantCode=$merchCode&merchantRefNumber=$merchantRefNum&signature=$hash";
                                  print(url);
                                  //print(concatData);
                                  loading = true;
                                  print(" $index can be checked now");

                                  return FutureBuilder(
                                      future: _fetchData(
                                          "https://www.atfawry.com//ECommerceWeb/Fawry/payments/status?merchantCode=$merchCode&merchantRefNumber=$merchantRefNum&signature=$hash"),
                                      builder: (context, snapshot) {
                                        Response FawryState = snapshot.data;
                                        var paymentStatus =
                                            FawryState.data["paymentStatus"];
                                        print(paymentStatus);
                                        switch (paymentStatus) {
                                          case "EXPIRED":
                                            {

                                              Firestore.instance
                                                  .collection('pgs')
                                                  .document("$pgname")
                                                  .collection(
                                                      DateFormat('dd MMM yyyy')
                                                          .format(date))
                                                  .document("h$index")
                                                  .updateData({
                                                'color': 'green',
                                                'merchrefnum': "",
                                                'Expired time': ""
                                              });
                                            }
                                            break;
                                          case "UNPAID":
                                            {

                                              Firestore.instance
                                                  .collection('pgs')
                                                  .document("$pgname")
                                                  .collection(
                                                      DateFormat('dd MMM yyyy')
                                                          .format(date))
                                                  .document("h$index")
                                                  .updateData({
                                                'color': 'green',
                                                'merchrefnum': "",
                                                'Expired time': "",
                                                'reservedBy': '',
                                              });
                                            }
                                            break;
                                          case "PAID":
                                            {

                                              changeProcessToPaid(
                                                  res: reservation_uid,
                                                  ref: refnum);

                                              changeProcessToRed(
                                                  pgname: pgname,
                                                  date: date,
                                                  index: index);

                                            }
                                            break;

                                          default:
                                            {
                                              reservationColor = Colors.yellow;
                                            }
                                            break;
                                        }
                                        var c = Colors.yellow;
                                        return Stack(children: <Widget>[
                                          Container(
                                            height: 70,
                                            color: selectionColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: c,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    "$textofindex",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                              visible: loading,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    7, 7, 0, 0),
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ),
                                              ))
                                        ]);
                                      });
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: InkWell(
                                    child: Stack(children: <Widget>[
                                      Container(
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
                                                "$textofindex",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible: loading,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(7, 7, 0, 0),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                            ),
                                          ))
                                    ]),
                                    onTap: () {
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
                                                  "لقد قمت بتحديد الساعه ${selectedItems.toString()} لالغاء التحديد انقر مرتين علي الساعه المراد الغاء تحديدها ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ));
                                            Scaffold.of(context)
                                                .showSnackBar(snack);
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ));
                                              Scaffold.of(context)
                                                  .showSnackBar(snack);
                                            });
                                          }
                                          break;
                                        case 'yellow':
                                          {
                                            setState(() {
                                              var snack = SnackBar(
                                                  backgroundColor:
                                                      Colors.yellow,
                                                  content: Text(
                                                    "هذه الساعه محجوزه مؤقتا بانتظار الدفع ",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ));
                                              Scaffold.of(context)
                                                  .showSnackBar(snack);
                                            });
                                          }
                                          break;
                                      }
                                    },
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
                                                  : "you have select ${selectedItems.toString()} ",
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
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                    color: Colors.yellow,
                    onPressed: () {
                      if (selectedItems.length != 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Confirmation(
                                      selecteditems: selectedItems,
                                      date: DateFormat('dd MMM yyyy')
                                          .format(date),
                                      pgname: pgname,
                                      umail: usermail,
                                      uid: userId,
                                    )));
                      } else {
                        var snack1 = SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.blue,
                            content: Text(
                              "لم تحدد أي ساعه",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ));
                        Scaffold.of(context).showSnackBar(snack1);
                      }
                    },
                    child: Text(
                      "confirmation",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  adduReservationtodb({int inty, String date, int price}) {
    Map<String, dynamic> addReservedHour = {
      'color': 'green',
      'index': inty,
      'price': price,
      //'merchrefnum': "",
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
    print("data created for this hour");
  }
}

changeProcessToRed({String pgname, date, index}) async {
  await Firestore.instance
      .collection('pgs')
      .document("$pgname")
      .collection(DateFormat('dd MMM yyyy').format(date))
      .document("h$index")
      .updateData({
    'color': 'red',
  });
}

Future<void> changeProcessToPaid({String res, ref}) async {
  await Firestore.instance
      .collection('users')
      .document(res)
      .collection("Transaction")
      .document(ref)
      .updateData({
    'pay': "paid",
  });
  print("paid");
}

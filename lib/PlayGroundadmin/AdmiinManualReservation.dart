import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:giffy_dialog/giffy_dialog.dart';


class AdmiinManualReservation extends StatefulWidget {
  int price1 , price2 , price3 ;
  String pgname;

  AdmiinManualReservation({this.pgname,this.price1,this.price2,this.price3});

  @override
  _AdmiinManualReservationState createState() =>
      _AdmiinManualReservationState(pgname);
}

class _AdmiinManualReservationState extends State<AdmiinManualReservation> {
  bool isSelected;

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
                    DateFormat('dd MMM yyyy').format(date),
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
                          .collection(DateFormat('dd MMM yyyy').format(date))
                          .orderBy('index', descending: false)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: const Text('Loading events...'));
                        } else if (snapshot.data.documents.length < 24) {
                          for (int x = 0; x < 4; x++) {
                            addReservationtodb(date:DateFormat('dd MMM yyyy').format(date),inty:x ,price: widget.price1);
                          };
                          for (int x = 4; x < 17; x++) {
                            addReservationtodb(date:DateFormat('dd MMM yyyy').format(date),inty: x ,price: widget.price2 );
                          };
                          for (int x = 17; x < 24; x++) {
                            addReservationtodb(date:DateFormat('dd MMM yyyy').format(date),inty: x ,price: widget.price3);
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

                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {

                                      if(reservation_color=="red"){
                                        showDialog(context: context,
                                            builder:(_){
                                              return    StreamBuilder(
                                                  stream: Firestore.instance
                                                      .collection("pgs")
                                                      .document("$pgname")
                                                      .collection(DateFormat('dd MMM yyyy').format(date))
                                                      .orderBy('index', descending: false)
                                                      .snapshots(),

                                                  builder: (BuildContext context, snapshot) {
                                                    return SizedBox(
                                                      height: 50,
                                                      child: AlertDialog(contentPadding: EdgeInsets.all(2),
                                                        title: Text("بيانات الساعة المحجوزة"),
                                                        content: SizedBox(height: 100,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text("تم حجزها بواسطه "),
                                                              Text(snapshot.data.documents[index]["mobile"]==null?"admin":snapshot.data.documents[index]["mobile"].toString()),
                                                              Text("المبلغ المدفوع "),
                                                              Text(snapshot.data.documents[index]["price"].toString()),

                                                              //Text("الموبايل:0101520")
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                              );


                                            }
                                        );
                                      }


                                      if (reservation_color=="green"){
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
                                                      .document("$pgname")
                                                      .collection(
                                                      DateFormat('dd MMM yyyy')
                                                          .format(date))
                                                      .document("h$index")
                                                      .updateData({
                                                    'color': 'red',
                                                    'reservedby': 'admin'
                                                  });

                                                  Navigator.of(context).pop();
                                                }));
                                      }
                                    },
                                    onLongPress: () {
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
                                    },
                                    child: Container(
                                      height: 50,
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

  addReservationtodb({int inty, String date,int price}) {
    Map<String, dynamic> addReservedHour = {
      'color': 'green',
      'index': inty,
      'price':price ,
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

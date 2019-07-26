import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tickets extends StatefulWidget {
  String userid;
  Tickets({this.userid});

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document('${widget.userid}')
                    .collection('Transaction')
                    .where("pay", isEqualTo: "paid")
                    .orderBy('reservation time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Container(
                      alignment: Alignment.center,
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.lightGreen,
                      child: Text(
                        " Loading tickets .... ",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ));
                  }

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot pgSnapshot =
                            snapshot.data.documents[index];

                        return Card(
                          borderOnForeground: true,
                          elevation: 123,
                          color: Colors.white30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: SingleChildScrollView(
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * .93,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "تــزكــــره ملعب",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Table(
                                          columnWidths: {
                                            1: FractionColumnWidth(.7)
                                          },
                                          border: TableBorder.all(
                                              color: Colors.black12),
                                          children: [
                                            TableRow(children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: Text(
                                                  "الملعب",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 25,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 5, top: 6),
                                                child: Text(
                                                  pgSnapshot['pgname'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                              )
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: Text(
                                                  "اليوم",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 25,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                pgSnapshot['day'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              )
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: Text(
                                                  "الساعه",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 25,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                pgSnapshot['hours'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              )
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: Text(
                                                  "الاسم",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 25,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "Ahmed",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              )
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: Text(
                                                  "الموبايل",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                pgSnapshot['mobile'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              )
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: Text(
                                                  "رقم الفاتوره",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                pgSnapshot['refnum'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              )
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: Text(
                                                  "تاريخ الحجز",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  pgSnapshot[
                                                      'reservation time'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                  textAlign: TextAlign.right,
                                                ),
                                              )
                                            ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget tabelticeket(var context) {
  return Card(
    borderOnForeground: true,
    elevation: 123,
    color: Colors.teal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * .86,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "تــزكــــره ملعب",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Table(
                  columnWidths: {1: FractionColumnWidth(.7)},
                  border: TableBorder.all(color: Colors.black12),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "الملعب",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5, top: 6),
                        child: Text(
                          "CampNou",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "اليوم",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        "3 يوليو",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "الساعه",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        "الخامسه",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "الاسم",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        "أحمد",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "الموبايل",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        "01553969051",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "رقم الفاتوره",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        "3232326565",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "تاريخ الحجز",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "3 يوليو الساعه 12 مساء",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

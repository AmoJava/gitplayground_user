import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tickets extends StatefulWidget {
  String userid;
  Tickets ({this.userid});

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    .orderBy('Expired time', descending: true)
                    .snapshots(),
                builder: (context, snapshot){
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
                      itemBuilder: (context,index){
                        DocumentSnapshot pgSnapshot =
                        snapshot.data.documents[index];

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
                                                pgSnapshot['pgname'],
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
                                              pgSnapshot['day'],
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
                                              pgSnapshot['hours'],
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

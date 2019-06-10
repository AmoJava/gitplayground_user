import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playground_user/User/Reservationpage.dart';

class PlayGroundList extends StatefulWidget {
  static const String id = "pglist";
  @override
  _PlayGroundListState createState() => _PlayGroundListState();
}

class _PlayGroundListState extends State<PlayGroundList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("الملاعب المتاحه"), backgroundColor: Colors.lightGreen,),
        body: Container(
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white30,
                child: StreamBuilder(
                    stream: Firestore.instance.collection('pgs').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Text(
                              " Loading play grounds .... ",
                              style: TextStyle(fontSize: 25),
                            ));
                      }
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot pgSnapshot =
                            snapshot.data.documents[index];

                            return Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 90,
                              child: InkWell(
                                onTap: () =>
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReservationPage(
                                                  pgname: "${pgSnapshot["name"]}",
                                                ))),
                                child: Card(
                                  elevation: 2,
                                  color: Colors.green.shade100,
                                  child: Center(
                                      child: Row(
                                        children: <Widget>[

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(radius: 35,
                                              backgroundImage: NetworkImage(
                                                  "${pgSnapshot["pgpic"]}"),
                                            ),
                                          ),
                                          Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "  ${pgSnapshot["name"]}",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w900),
                                                  ),
                                                  Text(
                                                    "  ${pgSnapshot["address"]}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w100),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )),
                                ),
                              ),
                            );
                          });
                    }),
              )),
        ));
  }
}

import 'package:flutter/material.dart';

import 'Reservationpage.dart';

class PlayGroundList extends StatefulWidget {
  static const String id = "pglist";
  @override
  _PlayGroundListState createState() => _PlayGroundListState();
}

class _PlayGroundListState extends State<PlayGroundList> {
  List names = ["gam3a", "talkha", "ahly", "zamalek", "mansoura"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: ListView(
      children: <Widget>[
          InkWell(child: PgItem(name: "Ahly "),onTap: (){
            Navigator.pushNamed(context, ReservationPage.id);
          },),
          PgItem(name: "Zamalek"),
          PgItem(name: "Elboshy"),
          PgItem(name: "gam3a"),
          PgItem(name: "talkha"),
          PgItem(name: "drsata"),
          PgItem(name: "zhor"),
          PgItem(name: "ngoom"),
          PgItem(name: "10 street"),
          PgItem(name: "fifa"),
          PgItem(name: "mansoura stadium"),
      ],
    ),
        ));
  }
}

class PgItem extends StatelessWidget {
  String name;
  PgItem({this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Card(
        elevation: 2,
        color: Colors.green.shade300,
        child: Center(child: Text("  $name")),
      ),
    );
  }
}

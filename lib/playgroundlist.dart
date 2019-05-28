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
          child:  ListView.builder(itemCount: names.length,itemBuilder:(BuildContext context,int index){
            return PgItem(name: names[index],);
          } ,)
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

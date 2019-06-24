import 'package:flutter/material.dart';
import 'package:playground_user/User/Fawry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Confirmation extends StatefulWidget {
  static const String id = "Confirmation";
  List selecteditems;
  var date ;
  String pgname;

  Confirmation({this.selecteditems, this.date, this.pgname});
  @override
  _ConfirmationState createState() =>
      _ConfirmationState(selecteditems, date, pgname);
}

class _ConfirmationState extends State<Confirmation> {
  List selecteditems;
  var date = new DateTime.now();
  String pgname;

  _ConfirmationState(this.selecteditems, this.date, this.pgname);
  var price;
  @override
  Widget build(BuildContext context) {
    print("${selecteditems.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text("تاكيد الحجز"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("pgs")
                .document("damana")
                .collection("03 Jun 2019").document('h${selecteditems[0].toString()}')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Text(
                  " Loading prices .... ",
                  style: TextStyle(fontSize: 25),
                ));
              }
              return ListView.builder(
                  itemCount: selecteditems.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot pgSnapshot = snapshot.data;
                      String price = pgSnapshot['price'].toString();
                    return Card(child: Row(children: <Widget>[
                      CircleAvatar(child: Text(price),)
                    ],),);

                  });
            }),
      ),

/*
            DocumentReference ref = Firestore.instance.document("/pgs/damana/03 Jun 2019/h${selecteditems[index].toString()}");
            ref.get().then((datasnapshot) {

              if (datasnapshot.exists) {
                setState(() {
                  price = datasnapshot.data['price'];
                });


              }
            });
            return Container(
                child: Column(
              children: <Widget>[
                Text("hello + ${selecteditems[index].toString()}"),
                Text ("$price"),
              ],
            ));*/

      /*ListView(
          children: <Widget>[
          Text("$pgname"),
          Column(children: <Widget>[
          Text(" الساعات المحجوزةبتاريخ  "  +date.toString()),

          ListTile(
          leading: CircleAvatar(backgroundColor: Colors.red,child: Text(selecteditems[0].toString()),),


          ),
          ListTile(
          leading: CircleAvatar(backgroundColor: Colors.red,child: Text(selecteditems[1].toString()),),
          ),
          ListTile(
          leading: CircleAvatar(backgroundColor: Colors.red,child: Text(selecteditems[2].toString()),),
          )

          ],)


          ],

          ) ,*/

      /* Container(
        child: Column(

          children: <Widget>[


            Text("$index"),



                 Text(
                  " لقد قمت بحجز الساعه   $selecteditems ",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                ),
            Text(
              "قيمه الحجز 120 جنيها ",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.indigo.shade300,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(onPressed: () {}, child: Text("رجوع")),
                FlatButton(
                    onPressed: () {
                      // صفحه فوري
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Fawry()));
                    },
                    child: Text("الدفع"))
              ],
            )
          ],
        ),
      ),*/
    );
  }
}

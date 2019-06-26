import 'package:flutter/material.dart';
import 'package:playground_user/User/Fawry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Payment.dart';

class Confirmation extends StatefulWidget {
  static const String id = "Confirmation";
  List selecteditems;
  var date;
  String pgname;

  Confirmation(this.selecteditems, this.date, this.pgname);
  @override
  _ConfirmationState createState() =>
      _ConfirmationState(selecteditems, date, pgname);
}

class _ConfirmationState extends State<Confirmation> {
  List selecteditems;
  var date;
  String pgname;

  _ConfirmationState(this.selecteditems, this.date, this.pgname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Payment();
              }));
            },
            child: Text(
              "تاكيد الحجز",
            )),
        centerTitle: true,
      ),
      body: Container(
        height: 250,
        color: Colors.white,
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('/pgs/damana/$date/')
                .orderBy("index")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Text(
                  " Loading play grounds .... ",
                  style: TextStyle(fontSize: 25),
                ));
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Text("لقد قمت بإختـيـار"),
                    Expanded(
                      child: ListView.builder(
                          itemCount: selecteditems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Text(selecteditems[index].toString()),
                              ),
                                title: Container(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("day ::" + date.toString() ), //+
                                        Text(" price ::" + snapshot.data.documents[selecteditems[index]]["price"].toString() ),
                                        //Text("day ::" + date.toString() ),
                                      ],
                                    )),
                                 );
                          }),
                    ),
                    SizedBox(height: 15,),
                    Text( "total price " ),
                    SizedBox(height: 8,),
                    FlatButton(onPressed: (){

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Payment()));
                    }, child: Text("Pay"))
                  ],
                ),
              );

              /*
         Container(child:  ListView.builder(itemCount: selecteditems.length,
itemBuilder: (BuildContext context,int index){
return ListTile(
title: Text(" الساعات المحجوزةبتاريخ  "  +date.toString()+" $pgnameملعب"),
subtitle:CircleAvatar(backgroundColor: Colors.red,child: Text(selecteditems[index].toString()),));

}

),)







"    $pgname   ملعب " +


















         return ListView.builder(
            itemCount: snapshot.data.documents.length,

              itemBuilder: (context,index){
                DocumentSnapshot pgSnapshot =
                snapshot.data.documents[index];

                return Text(pgSnapshot[]["price"].toString());

             });*/
            }),
      ),

      /**ListView(
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

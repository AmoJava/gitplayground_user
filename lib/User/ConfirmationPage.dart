import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queries/collections.dart';

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

int sum = 0 ;


  List pricelist = [] ;
  List selecteditems;
  var date;
  String pgname;
  static int tp =0 ;
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
        height: 450,
        color: Colors.white,
        child: StreamBuilder(
            stream: Firestore.instance.collection('/pgs/damana/$date/').orderBy("index").snapshots(),
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

                            int price = snapshot.data.documents[selecteditems[index]]["price"] ;

                            pricelist.add(price);

                            print(pricelist);

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

                    Text( "total  $tp" ),
                    SizedBox(height: 8,),
                    FlatButton(onPressed: (){

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Payment()));
                    }, child: Text("Pay"))
                  ],
                ),
              );

            }),
      ),

    );
  }

  @override
  void initState() {
    super.initState();

    for(final i in selecteditems){

      DocumentReference ref = Firestore.instance.collection('pgs').document("damana").collection('$date').document("h$i");
      ref.get().then((datasnapshot) {
        if (datasnapshot.exists) {

          int  price  = datasnapshot.data['price'];

           sum = sum +price;


          print(sum);
          setState(() {
            tp=sum ;
          });
        }
      });


      /*print('$i');
      if (i == 2){
        break;
      }*/
    }

  }

}


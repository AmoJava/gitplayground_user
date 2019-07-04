import 'package:flutter/material.dart';

class Tickets extends StatefulWidget {
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
            SizedBox(height: 25,),
            Expanded(
              child: ListView(shrinkWrap: true,scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ticket(),
                  ticket(),
                  ticket()

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ticket() {
  return Padding(
    padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
    child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,color: Colors.teal,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        height: 100,
        width: 280,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            Column(
              children: <Widget>[
                Text("Refnumber",style: TextStyle(fontSize: 15,color: Colors.black),),
                Text("9009523",style: TextStyle(fontSize: 25,color: Colors.white),),
              ],
            ),

SizedBox(height: 15,),

Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
          Column(
            children: <Widget>[
              Text("name",style: TextStyle(fontSize: 13,color: Colors.black),),
        Text("amo",style: TextStyle(fontSize: 25,color: Colors.white),),
            ],
          ),

        Column(
          children: <Widget>[
            Text("pg name",style: TextStyle(fontSize: 13,color: Colors.black),),
            Text("damana",style: TextStyle(fontSize: 25,color: Colors.white),),
          ],
        ),

          ],),
            SizedBox(height: 15,),


            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
              Column(
                children: <Widget>[
                  Text("day",style: TextStyle(fontSize: 13,color: Colors.black),),
                  Text("03 - july ",style: TextStyle(fontSize: 25,color: Colors.white),),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("hour",style: TextStyle(fontSize: 13,color: Colors.black),),
                  Text("3",style: TextStyle(fontSize: 25,color: Colors.white),),
                ],
              ),
            ],),
SizedBox(height:15),
            Column(
              children: <Widget>[
                Text("booked in ",style: TextStyle(fontSize: 13,color: Colors.black),),
                Text("23 may 2018 12: 12",style: TextStyle(fontSize: 18,color: Colors.white),),

              ],
            ),
            SizedBox(height: 15,)
          ,
            Column(
              children: <Widget>[
                Text("mobile",style: TextStyle(fontSize: 13,color: Colors.black),),
                Text("01553969051",style: TextStyle(fontSize: 18,color: Colors.white),),
              ],
            ),

          ],
        ),
      ),
    ),
  );
}

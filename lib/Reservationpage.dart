import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  static const String id = "reservationPage";
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
var mycolor = Colors.white ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("mal3abElahly "),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/mal3ab.jpg"),
                      fit: BoxFit.fitWidth)),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              " 1 May ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
            )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              color: Colors.red,
              child: GridView.count(crossAxisCount: 6,children: List.generate(24, (index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: GestureDetector(
                            onTap: (){
                              print(index);
                              setState(() {
                                mycolor =Colors.green;
                              });
                            },

                      child: Container(
                        decoration: BoxDecoration(color: mycolor,shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            ' ${index}',
                            style: Theme.of(context).textTheme.headline,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ))
          ],
        ),
      ),
    );
  }
}

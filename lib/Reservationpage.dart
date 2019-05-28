import 'package:flutter/material.dart';
import 'package:queries/collections.dart';
import 'package:flutter_multi_carousel/carousel.dart';

String highlevel ;

class ReservationPage extends StatefulWidget {
  static const String id = "reservationPage";

  String pgname;

  ReservationPage(this.pgname);

  @override
  _ReservationPageState createState() => _ReservationPageState(pgname);
}

class _ReservationPageState extends State<ReservationPage> {
  _ReservationPageState(this.pgname);

  String pgname;

  int indexX;

  var mycolor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("mal3ab$pgname "),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Carousel(
                  axis: Axis.horizontal,
                  indicatorType: "dot",
                  showIndicator: true,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  type: "simple",
                  children: [
                    Image.asset(
                      'assets/pg1.jpg',
                      fit: BoxFit.fill,
                    ),
                    Image.asset('assets/pg2.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg3.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg4.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg5.jpg', fit: BoxFit.fill),
                    Image.asset('assets/pg6.jpg', fit: BoxFit.fill),
                  ]),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    " Today  1 May ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  IconButton(icon: Icon(Icons.calendar_today), onPressed: () {

                  })
                ],
              )),

              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  color: Colors.white,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 6,
                    children: List.generate(24, (index) {
                      indexX = index;
                      return HourElement(
                        num: index,
                        isNotReservedBefore: false,
                      );
                    }),
                  )),

              FlatButton(onPressed: () {}, child: Text("تأكيد الحجز",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      ),
    );
  }
}

class HourElement extends StatefulWidget {
  HourElement({this.num, this.isNotReservedBefore});
  int num;
  bool isNotReservedBefore;

  @override
  _HourElementState createState() => _HourElementState(
      hourIndex: num, isNotReservedBefore: isNotReservedBefore);
}

class _HourElementState extends State<HourElement> {
  int hourIndex;
  _HourElementState({this.hourIndex, this.isNotReservedBefore});

  bool isNotReservedBefore;
  bool isSelected;
  var reservationColor;
  static List tapedItems;
  static List selectedItems;

  @override
  void initState() {
    tapedItems = [];
    selectedItems = [];

    if (isNotReservedBefore == true) {
      reservationColor = Colors.green;
    } else
      reservationColor = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (isNotReservedBefore==true){
            print(hourIndex);
            tapedItems.add(hourIndex);
            selectedItems = Collection(tapedItems).distinct().toList();
            print(tapedItems);
            print(selectedItems.toList());

            var snack = SnackBar(duration: Duration(seconds: 2),
                backgroundColor: Colors.blue,
                content: Text(
                  "you have select ${selectedItems.toString()} ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ));
            Scaffold.of(context).showSnackBar(snack);
            //reservationColor=Colors.green;
            //isNotReservedBefore=true ;

            }


            switch (isNotReservedBefore) {
              case true:
                {
                  setState(() {
                    reservationColor = Colors.blue;
                    isSelected = true;
                  });
                }
                break;
              case false:
                {
                  setState(() {
                    var snack = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "هذه الساعه محجوزه مسبقا ",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ));
                    Scaffold.of(context).showSnackBar(snack);
                    //reservationColor=Colors.green;
                    //isNotReservedBefore=true ;
                  });
                }
                break;
            }

          },
          onDoubleTap: () {
            if (isNotReservedBefore == true) {
              tapedItems.remove(hourIndex);
              selectedItems.remove(hourIndex);
              //print(tapedItems);
              //print(Collection(tapedItems).distinct().toList());
              print(selectedItems);
              setState(() {
                reservationColor = Colors.green;
                if (selectedItems.isEmpty) {
                  tapedItems = [];
                }
              });
              var snack = SnackBar(duration: Duration(seconds: 2),
                  backgroundColor: Colors.blue,
                  content: Text(
                    selectedItems.isEmpty? "لم تحدد اي ساعه":"you have select ${selectedItems.toString()} ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ));
              Scaffold.of(context).showSnackBar(snack);
            }
          },
          child: Container(
            height: 40,
            decoration:
                BoxDecoration(color: reservationColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                "$hourIndex",
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

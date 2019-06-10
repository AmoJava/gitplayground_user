import 'package:flutter/material.dart';

import 'Reservationpage.dart';
import 'congratulation.dart';

class Fawry extends StatefulWidget {
  @override
  _FawryState createState() => _FawryState();
}

class _FawryState extends State<Fawry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(
                "هنا صفحه فوري",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "في انتظار الدفع",
                style: TextStyle(fontSize: 15),
              ),
              //زر وهمي فقط للوصل  الصفحه التاليه لصفحه فوري في حاله اتمام الدفع طبعا سيتم الغاءه عند اضاءه كود فوري
              InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Congratulation()));
                  },
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellowAccent,
                  )),
              Spacer(),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationPage()));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      color: Colors.red,
                      child: Text(
                        "الغاء الدفع و العودة",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

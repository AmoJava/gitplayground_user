import 'package:flutter/material.dart';

import 'Tickets.dart';

class Congratulation extends StatefulWidget {
  @override
  _CongratulationState createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation> {
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
                "تهانينا احمد",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "لقد اتممت حجز الساعه المطلوبه",
                style: TextStyle(fontSize: 15),
              ),
              //زر وهمي فقط للوصل  الصفحه التاليه لصفحه فوري في حاله اتمام الدفع طبعا سيتم الغاءه عند اضاءه كود فوري

              Spacer(),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Tickets()));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      color: Colors.green,
                      child: Text(
                        "التذاكر الخاصه بك",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

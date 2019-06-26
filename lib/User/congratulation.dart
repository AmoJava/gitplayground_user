import 'package:flutter/material.dart';
import 'package:playground_user/User/UserProfile.dart';
import 'package:playground_user/User/paybyFawry.dart';
import 'Tickets.dart';

class Congratulation extends StatelessWidget {
  var refNumber, ExpirationDate;

  Congratulation({this.refNumber, this.ExpirationDate});

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
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                " يمكنك الآن الذهاب لاقرب نقطه فوري و  تنفيذ عمليه الدفع  لاتمام عمليه الحجز قبل  ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "${DateTime.fromMillisecondsSinceEpoch(ExpirationDate)}",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.pink,
                    fontWeight: FontWeight.w800),
              ),
              Text("رقم العمليه "),
              Text(
                "  $refNumber  ",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
              ),
              Text(
                "  ستجد ايضا الرقم علي الموبايل الذي قمت بادخاله سابقا  ",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 25),
              ),
              Text(
                " ملاحظه لن تكتمل عمليه الحجز اذا لم تقم بالدفع خلال 1 ساعه من الآن و سيكون بمقدور اي شخص حجز الساعه مره اخري ",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 15),
              ),
              //زر وهمي فقط للوصل  الصفحه التاليه لصفحه فوري في حاله اتمام الدفع طبعا سيتم الغاءه عند اضاءه كود فوري

              Spacer(),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => UserProfile()));
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

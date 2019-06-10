import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Payment extends StatefulWidget {
  static const String id = "Paymemt";
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.document("/pgs/fifa/30 May").snapshots(),
        builder: ( context,  snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
            map.forEach((dynamic, v) => print(v["isReserved"]));
                return Container(
                  height: 250,
                  width: 200,
                );
          }
}
        );}}

/*
return GridView.builder(
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 3),
itemCount: map.values.toList().length,
padding: EdgeInsets.all(2.0),
itemBuilder: (BuildContext context, int index) {
return Container(
child: Image.network(
map.values.toList()[index]["pic"],
fit: BoxFit.cover,
),
padding: EdgeInsets.all(2.0),
);
},
);
} else {
return CircularProgressIndicator();
}
});
*/

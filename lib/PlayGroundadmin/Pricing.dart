import 'package:flutter/material.dart';

class PricingPanal extends StatefulWidget {
  int price1, price2, price3;
  PricingPanal({this.price1, this.price2, this.price3});
  @override
  _PricingPanalState createState() => _PricingPanalState();
}

class _PricingPanalState extends State<PricingPanal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الاسعار",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("الأسعار ",style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.w900),),
            Text("الفتره  من 4 صباحا حتي 6 مساءا"),
            Text("${widget.price2}"),
            Text("الفتره من 6 مساءا حتي 4 صباحا"),
            Text("${widget.price3}"),
          ],
        ),
      ),
    );
  }
}

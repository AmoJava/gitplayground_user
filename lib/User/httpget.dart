import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
gryhttp()async{

}

class nn extends StatefulWidget {


  String n1 ;
  @override
  _nnState createState() => _nnState();
}


class _nnState extends State<nn> {

  String n ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(body:
    Center(child:
    Column(
      children: <Widget>[
        FlatButton(onPressed: (){
          var date = DateTime.now();

          print('date of now = $date');
          print('date of nowEpoch = ${date.toUtc().millisecondsSinceEpoch}');
          var dateplushour = date.add(new Duration(hours: 1));
          print('date of now = $dateplushour');
          var msepoch = dateplushour.toUtc().millisecondsSinceEpoch ;
          print("print Epoch $msepoch");
          print('date of nowEpoch = ${dateplushour.toUtc().millisecondsSinceEpoch}');
          var dateorginal = new DateTime.fromMillisecondsSinceEpoch( msepoch);

          print ("return to orignal date $dateorginal");

        },child: Text("time of now")),
        FlatButton(onPressed: ()async{

          //Navigator.push(context, MaterialPageRoute(builder: (_)=>bnkhaldon()));
          /*Response response;
          Dio dio = new Dio();
          response = await dio.get("https://atfawry.fawrystaging.com/ECommerceWeb/Fawry/payments/status?merchantCode=1PC8/vkn3GzHnfhDcneBrA==&merchantRefNumber=0000003202&signature=927d1875d02ef6b1c1c9e694f1c6c56e4469fce9d6d76a07283d24eb32a950c0");
          print(response.data.toString());*/


        }, child:Text("cc")),
      ],
    ),),);
  }

  @override
  void initState() {
    gryhttp();
  }
}


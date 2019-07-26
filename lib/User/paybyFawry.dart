import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class payatfawry extends StatefulWidget {
  String userid;
  payatfawry({this.userid});
  @override
  _payatfawryState createState() => _payatfawryState();
}

class _payatfawryState extends State<payatfawry> {
  String merchrefnum;

  _fetchData(String url) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(url);
    print(DateTime.now().millisecondsSinceEpoch);
    return response;
  }


  @override
  Widget build(BuildContext context) {


    print(DateTime.now().millisecondsSinceEpoch);
    //_fetchData();
    return Scaffold(
        appBar: AppBar(
          title: Text("ادفع في فوري"),
          backgroundColor: Colors.lightGreen,
        ), //1564160105046
        body: Container(
          color: Colors.green,
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    "فواتير تستحق الدفع في فوري ",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "يمكنك الآن التوجه الي اقرب فرع فوري و القيام باختيار خدمه الدفع برقم فوري باي او بكود  كود خدمه 788 لاتمام عمليه الحجز",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white10,
                      child: StreamBuilder(
                          stream: Firestore.instance
                              .collection('users')
                              .document('${widget.userid}')
                              .collection('Transaction')
                              .where("Expired time",
                                  isGreaterThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
                              .orderBy('Expired time', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 20, left: 20, bottom: 15),
                                    child: LinearProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.green),
                                      backgroundColor: Colors.lightGreenAccent.shade100,
                                    ),
                                  ),
                                  Text(
                                    " يتم تحميل الفواتير .... ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ));
                            } else if (snapshot.data.documents.length == 0) {
                              return Center(
                                child: Text(
                                  "لا يوجد لديك طلبات تستحق الدفع ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              );
                            }
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot pgSnapshot =
                                      snapshot.data.documents[index];

                                  return Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Card(
                                          elevation: 2,
                                          color: Colors.transparent,
                                          child: Center(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          color: Colors.white)),
                                                  //height: 230,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                                "رقم العمليه",style: TextStyle(color: Colors.white),)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          "${pgSnapshot["refnum"]}",
                                                          style: TextStyle(
                                                              fontSize: 38,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          //DateFormat("yMd").format(DateTime.fromMillisecondsSinceEpoch(pgSnapshot["Expired time"]))
                                                          //DateFormat(' dd MMM yyyy  @ hh:mm').format(pgSnapshot["Expired time"])
                                                          " will expire in ${DateFormat("yMd HH-mm").format(DateTime.fromMillisecondsSinceEpoch(pgSnapshot["Expired time"]))}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        color:
                                                            Colors.lightGreen,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              "بيانات الحجز ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            Container(alignment: Alignment.centerRight,
                                                                child: Table(
                                                                  columnWidths: {
                                                                    1: FractionColumnWidth(
                                                                        .7)
                                                                  },
                                                                  border: TableBorder.all(
                                                                      color: Colors
                                                                          .black12),
                                                                  children: [
                                                                    TableRow(
                                                                        children: [
                                                                          Center(
                                                                              child: Text("Playground name",textAlign: TextAlign.center,)),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 3),
                                                                            child:
                                                                                Text(
                                                                              "${pgSnapshot["pgname"]}",
                                                                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                    TableRow(
                                                                        children: [
                                                                          Center(
                                                                              child: Text("day")),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 3),
                                                                            child:
                                                                                Text(
                                                                              "${pgSnapshot["day"]}",
                                                                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                    TableRow(
                                                                        children: [
                                                                          Center(
                                                                              child: Text("Hour")),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 3),
                                                                            child:
                                                                                Text(
                                                                              "${pgSnapshot["hours"]}",
                                                                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                  ],
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ))),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                    ),
                  ),
                ],
              )),
        ));
  }
}

/*
class refnumquery extends StatefulWidget {
  @override
  _refnumqueryState createState() => _refnumqueryState();
}

class _refnumqueryState extends State<refnumquery> {
  @override
  void initState() {
    //_fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        width: 300,
        child: Center(
            child: FutureBuilder(
                future: _fetchData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        DioError error = snapshot.error;
                        String message = error.message;
                        if (error.type == DioErrorType.CONNECT_TIMEOUT)
                          message = 'Connection Timeout';
                        else if (error.type == DioErrorType.RECEIVE_TIMEOUT)
                          message = 'Receive Timeout';
                        else if (error.type == DioErrorType.RESPONSE)
                          message =
                              '404 server not found ${error.response.statusCode}';
                        return Center(child: Text('Error: ${message}'));
                      }

                      Response response = snapshot.data;

                      var ed = response.data["expirationTime"];
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(response.data["referenceNumber"].toString()),
                            Text(response.data["merchantRefNumber"].toString()),
                            Text(response.data["paymentAmount"].toString()),
                            Text(DateTime.fromMillisecondsSinceEpoch(ed)
                                .toString()), //
                            Text(response.data["paymentStatus"].toString()),
                          ],
                        ),
                      );
                  }
                })),
      ),
    );
  }
}
*/

/*                                        context: context,
                                        builder: (_) => FutureBuilder(
                                            future: _fetchData(
                                                "https://atfawry.fawrystaging.com/ECommerceWeb/Fawry/payments/status?merchantCode=1PC8/vkn3GzHnfhDcneBrA==&merchantRefNumber=0000003202&signature=927d1875d02ef6b1c1c9e694f1c6c56e4469fce9d6d76a07283d24eb32a950c0"),
                                            builder: (context, snapshot) {
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.none:
                                                case ConnectionState.waiting:
                                                case ConnectionState.active:
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                case ConnectionState.done:
                                                  if (snapshot.hasError) {
                                                    DioError error =
                                                        snapshot.error;
                                                    String message =
                                                        error.message;
                                                    if (error.type ==
                                                        DioErrorType
                                                            .CONNECT_TIMEOUT)
                                                      message =
                                                          'Connection Timeout';
                                                    else if (error.type ==
                                                        DioErrorType
                                                            .RECEIVE_TIMEOUT)
                                                      message =
                                                          'Receive Timeout';
                                                    else if (error.type ==
                                                        DioErrorType.RESPONSE)
                                                      message =
                                                          '404 server not found ${error.response.statusCode}';
                                                    return Center(
                                                        child: Text(
                                                            'Error: $message'));
                                                  }

                                                  Response response =
                                                      snapshot.data;

                                                  var ed = response
                                                      .data["expirationTime"];
                                                  var paymentStatus = response
                                                      .data["paymentStatus"];

                                                  merchrefnum = response
                                                      .data["merchantRefNumber"]
                                                      .toString();

                                                  switch (paymentStatus) {
                                                    case "EXPIRED":
                                                      {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          title: Text(
                                                              "EXPIRED process"),
                                                          elevation: 2,
                                                          content: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(response
                                                                    .data[
                                                                        "referenceNumber"]
                                                                    .toString()),
                                                                Text(response
                                                                    .data[
                                                                        "merchantRefNumber"]
                                                                    .toString()),
                                                                Text(response
                                                                    .data[
                                                                        "paymentAmount"]
                                                                    .toString()),
                                                                Text(DateTime
                                                                        .fromMillisecondsSinceEpoch(
                                                                            ed)
                                                                    .toString()), //
                                                                Text(response
                                                                    .data[
                                                                        "paymentStatus"]
                                                                    .toString()),

                                                                Spacer(),

                                                                FlatButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                        "لم تقم بالدفع ف الوقت المحدد اعد عمليه الحجز من اول و جديد"))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      } //end of the first case "expired"
                                                      break;

                                                    //case 2 if the process paid
                                                    case "PAID":
                                                      {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "paid process"),
                                                          elevation: 2,
                                                          content: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(response
                                                                    .data[
                                                                        "referenceNumber"]
                                                                    .toString()),
                                                                Text(response
                                                                    .data[
                                                                        "merchantRefNumber"]
                                                                    .toString()),
                                                                Text(response
                                                                    .data[
                                                                        "paymentAmount"]
                                                                    .toString()),
                                                                Text(DateTime
                                                                        .fromMillisecondsSinceEpoch(
                                                                            ed)
                                                                    .toString()), //
                                                                Text(response
                                                                    .data[
                                                                        "paymentStatus"]
                                                                    .toString()),

                                                                Spacer(),

                                                                FlatButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                        "now you can get ticket"))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      } //end of the first case "paid"
                                                      break;

                                                    //case 3 if the process paid
                                                    case "UNPAID":
                                                      {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "unpaid process"),
                                                          elevation: 2,
                                                          content: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(response
                                                                    .data[
                                                                        "referenceNumber"]
                                                                    .toString()),
                                                                Text(response
                                                                    .data[
                                                                        "merchantRefNumber"]
                                                                    .toString()),
                                                                Text(response
                                                                    .data[
                                                                        "paymentAmount"]
                                                                    .toString()),
                                                                Text(DateTime
                                                                        .fromMillisecondsSinceEpoch(
                                                                            ed)
                                                                    .toString()), //
                                                                Text(response
                                                                    .data[
                                                                        "paymentStatus"]
                                                                    .toString()),

                                                                Spacer(),

                                                                FlatButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                        "من اجل اتمام الحجز يرجي اكمال عمليه الدفع"))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      } //end of the first case "expired"
                                                      break;
                                                  }
                                              }
                                            })*/

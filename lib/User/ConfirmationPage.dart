import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playground_user/User/congratulation.dart';
import 'dart:math';
import 'Payment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Confirmation extends StatefulWidget {
  static const String id = "Confirmation";

  List selecteditems;
  String uid, umail;

  var date;
  String pgname;

  Confirmation(
      {this.umail, this.uid, this.selecteditems, this.date, this.pgname});
  @override
  _ConfirmationState createState() =>
      _ConfirmationState(selecteditems, date, pgname);
}

class _ConfirmationState extends State<Confirmation> {
  List selecteditems;
  var date;
  String pgname;
  _ConfirmationState(this.selecteditems, this.date, this.pgname);

  int sum = 0;
  List pricelist = [];
  static int tp = 0;
  int amount;
  String merchantRefNum;
  String merchCode = "1PC8/vkn3GzHnfhDcneBrA==";
  String secureCode = "aa8f660ed9804afdb7daeafdef009829";
  String userid, userMail;
  var mobile;
  int mobilelegnth;

  @override
  void initState() {
    super.initState();
    var random = Random.secure();
    var value = random.nextInt(1000000000);

    for (final i in selecteditems) {
      DocumentReference ref = Firestore.instance
          .collection('pgs')
          .document("damana")
          .collection('$date')
          .document("h$i");
      ref.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          int price = datasnapshot.data['price'];
          sum = sum + price;
          print(sum);
          setState(() {
            tp = sum;
          });
        }
      });
    }
    //print(widget.day);
    //print(widget.month);
    userid = widget.uid;
    userMail = widget.umail;
    merchantRefNum = "$value$pgname";
    print(merchantRefNum);
  }

  var correctnumbool = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Payment();
              }));
            },
            child: Text(
              "تاكيد الحجز",
            )),
        centerTitle: true,
      ),
      body: Container(
        height: 450,
        color: Colors.white,
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('/pgs/damana/$date/')
                .orderBy("index")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Text(
                  " Loading play grounds .... ",
                  style: TextStyle(fontSize: 25),
                ));
              }

              return Container(
                child: Column(
                  children: <Widget>[
                    Text("لقد قمت بإختـيـار"),
                    Expanded(
                      child: ListView.builder(
                          itemCount: selecteditems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Text(selecteditems[index].toString()),
                              ),
                              title: Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("day ::" + date.toString()), //+
                                  Text(" price ::" +
                                      snapshot
                                          .data
                                          .documents[selecteditems[index]]
                                              ["price"]
                                          .toString()),
                                  //Text("day ::" + date.toString() ),
                                ],
                              )),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("total  $tp"),
                    SizedBox(
                      height: 8,
                    ),
                    FlatButton(
                        onPressed: () {
                          showDialog(
                              child: new Dialog(
                                child: SingleChildScrollView(
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        "assets/fawry.png",
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Text("please enter your mobile number"),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                          setState(() {
                                            mobilelegnth = val.length;
                                          });

                                          mobile = val;
                                          print(val.length);
                                          print("val = $mobile");
                                        },
                                        onSubmitted: (value) {
                                          mobile = value;

                                          print(value.length);

                                          setState(() {
                                            mobilelegnth = value.length;
                                          });
                                          print(mobile);
                                        },
                                        decoration: new InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.mobile_screen_share),
                                            hintText: "01004545545 "),
                                      ),
                                      Text("سيصلك كود الدفع علي هذا الرقم"),
                                      Visibility(
                                        visible: true,
                                        child: FlatButton(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      30,
                                                    ),
                                                    bottomRight:
                                                        Radius.circular(30))),
                                            alignment: Alignment.center,
                                            height: 55,
                                            width: double.maxFinite,
                                            child: Text(
                                              "ادفع فوري",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (mobilelegnth == 11) {

                                              String concatData = merchCode +
                                                   merchantRefNum +
                                                   userid +
                                                   "PAYATFAWRY" +
                                                   "$tp.00" +
                                                   secureCode;
                                              List<int> bytes =
                                                  utf8.encode(concatData);
                                              String hash = sha256
                                                  .convert(bytes)
                                                  .toString();
                                              print("hash is $hash");

                                              var today = new DateTime.now();
                                              var expirationDate = today
                                                  .add(new Duration(hours: 1))
                                                  .toUtc()
                                                  .millisecondsSinceEpoch;
                                              print(expirationDate);

                                              // expire date that will be sent to the mobile of user
                                              var date = DateTime.now();
                                              print('date of now = $date');
                                              print(
                                                  'date of nowEpoch = ${date.toUtc().millisecondsSinceEpoch}');
                                              var dateplushour = date
                                                  .add(new Duration(hours: 1));
                                              print(
                                                  'date of nowplushour = $dateplushour');
                                              print(
                                                  'date of nowEpoch = ${dateplushour.toUtc().millisecondsSinceEpoch}');
                                              var expireDate = dateplushour
                                                  .toUtc()
                                                  .millisecondsSinceEpoch;

                                              var url =
                                                  'https://atfawry.fawrystaging.com//ECommerceWeb/Fawry/payments/charge';
                                              Map<String, dynamic> data = {
                                                "merchantCode": merchCode,
                                                "merchantRefNum":
                                                    merchantRefNum,
                                                "customerProfileId": userid,
                                                "customerMobile": mobile,
                                                "customerEmail": userMail,
                                                "paymentMethod": "PAYATFAWRY",
                                                "amount": tp,
                                                "currencyCode": "EGP",
                                                "description":
                                                    "hello first operation",
                                                "paymentExpiry":
                                                    expireDate, //1561379640000
                                                "chargeItems": [
                                                  {
                                                    "itemId":
                                                        "897fa8e81be26df25db592e81c31c",
                                                    "description":
                                                        "new description",
                                                    "price": 20.00,
                                                    "quantity": 1
                                                  }
                                                ],
                                                "signature": hash
                                              };
                                              final http.Response response =
                                                  await http.post(
                                                      Uri.encodeFull(url),
                                                      headers: {
                                                        "content-type":
                                                            "application/json",
                                                        "accept":
                                                            "application/json"
                                                      },
                                                      body: json.encode(data));
                                              String bb = response.body;
                                              print(bb);
                                              String rfn = jsonDecode(
                                                  bb)["referenceNumber"];
                                              var Expiretion = jsonDecode(
                                                  bb)["expirationTime"];
                                              print("expiretion time " +
                                                  "$Expiretion");
                                              print("refnum is " + "$rfn");

                                              String conc = merchCode +
                                                  merchantRefNum +
                                                  secureCode;
                                              List<int> bytess =
                                                  utf8.encode(conc);
                                              String hash2 = sha256
                                                  .convert(bytess)
                                                  .toString();
                                              print(
                                                  "https://atfawry.fawrystaging.com/ECommerceWeb/Fawry/payments/status?merchantCode=$merchCode&merchantRefNumber=$merchantRefNum&signature=$hash2");

                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Congratulation(
                                                            ExpirationDate:
                                                                Expiretion,
                                                            refNumber: rfn,
                                                          )));

                                              /*                                      addtranstodb(int refnum, int inty,
                                                String date) {
                                              Map<String, dynamic>
                                                  addReservedHour = {};
                                              print("upload data");
                                            }
*/
                                              for (final i in selecteditems) {
                                                print(i);
                                                Firestore.instance
                                                    .collection('pgs')
                                                    .document("$pgname")
                                                    .collection(widget.date)
                                                    .document("h$i")
                                                    .updateData({
                                                  'color': 'yellow',
                                                  'merchrefnum': merchantRefNum,
                                                  'Expired time': expireDate
                                                });
                                              }

                                              Firestore.instance
                                                  .collection('Transaction')
                                                  .document("damana")
                                                  .collection("1 june")
                                                  .document("h1")
                                                  .setData({
                                                'merchrefnum': merchantRefNum,
                                                'refnum': rfn,
                                                'index': 2,
                                                'pay': "not paid",
                                              });

                                              Firestore.instance
                                                  .collection('users')
                                                  .document(userid)
                                                  .collection("Transaction")
                                                  .document(rfn)
                                                  .setData({
                                                'merchrefnum': merchantRefNum,
                                                'Expired time':
                                                    "${date.add(new Duration(hours: 1))}",
                                                'hours':
                                                    '6', // loop for each hour
                                                'refnum': rfn,
                                                'pay': "not paid",
                                                'pgname': "damana",
                                                'day': " 1 june "
                                              });

                                              selecteditems = [];
                                            } else {
                                              print(
                                                  "please enter valid mobile number ");

                                              Alert(
                                                context: context,
                                                type: AlertType.warning,
                                                title: "Wrong mobile number",
                                                desc:
                                                    " ما تدخل رقم موبايل مظبوط ياعم -- الكود هيتبعت عليه",
                                                buttons: [
                                                  DialogButton(
                                                    child: Text(
                                                      "حاضر",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Color.fromRGBO(
                                                          116, 116, 191, 1.0),
                                                      Color.fromRGBO(
                                                          52, 138, 199, 1.0)
                                                    ]),
                                                  )
                                                ],
                                              ).show();
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              context: context);
                        },
                        child: Text("Pay"))
                  ],
                ),
              );
            }),
      ),
    );
  }
}

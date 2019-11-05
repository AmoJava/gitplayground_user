import "package:flutter/material.dart";

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(children : <Widget>[new GradientAppBar("Custom Gradient App Bar"), new Container()],);
  }
}


class GradientAppBar extends StatelessWidget {
  //var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  var firstColor = Colors.green, secondColor = Colors.lightGreen;

  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: new TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [firstColor, secondColor],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
    );
  }
}
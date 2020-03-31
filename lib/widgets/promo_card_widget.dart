

import 'package:fastshop_mobile/design/colors.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {

  final String title;
  final String date;

  const PromoCard({Key key, this.title, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        height: 20.0,
        child: new Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only (top: 20.0, bottom: 10.0, left: 10.0),
                child: new Text(title, style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black45))),
            //new Image.network(snapshot.data[index].uri, fit: BoxFit.cover),
            Padding(
                padding: EdgeInsets.only (top: 250.0, bottom: 10.0, left: 10.0),
                child: new Text(date, style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.black45))),
          ],
        ),
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: new Color(fCardColor.value),
            borderRadius: new BorderRadius.circular(20.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black54,
                  offset: new Offset(0.0, 0.0),
                  blurRadius: 10.0
              )
            ]
        )
    );
  }
}

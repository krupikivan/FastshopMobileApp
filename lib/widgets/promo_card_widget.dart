import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final Promocion promocion;

  const PromoCard({Key key, this.promocion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        height: 30.0,
        child: Container(
          padding: new EdgeInsets.symmetric(horizontal: 10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text(promocion.promocion,
                  style: new TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(
                promocion.producto,
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Desde ' +
                    promocion.fechaInicio.toString() +
                    '\n' +
                    'Hasta ' +
                    promocion.fechaFin.toString(),
                style: new TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: new Color(fPromoColor.value),
          borderRadius: new BorderRadius.circular(20.0),
        ));
  }
}

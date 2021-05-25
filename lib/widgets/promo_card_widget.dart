import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final Promocion promocion;

  const PromoCard({Key key, this.promocion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width - 70,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(13),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(promocion.promocion,
              style: new TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              promocion.producto,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Text(
            'Valido hasta ' + promocion.fechaInicio.toString(),
            style: new TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: fPromoCardBackColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 15.0,
            color: fPromoCardBackColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

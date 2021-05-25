import 'package:fastshop/blocs/home/promo_bloc.dart';
import 'package:fastshop/models/models.dart';
import 'package:fastshop/widgets/promo_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveOfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PromoBloc>(
        //Estamos escuchando al stream,
        //cuando el valor sale afuera del stream largamos la lista por pantalla
        builder: (context, snapshot, _) {
          if (snapshot.promociones.isNotEmpty) {
            //Aca largamos la lista a la pantalla
            return snapshot.promociones.length == 0
                ? Center(
                    child: Text('Sin promociones',
                        style: Theme.of(context).textTheme.display1))
                : buildList(snapshot.promociones);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildList(List<Promocion> snapshot) {
    return GridView.builder(
      itemCount: snapshot.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          enableFeedback: true,
          child: new PromoCard(promocion: snapshot[index]),
        );
      },
    );
  }
}

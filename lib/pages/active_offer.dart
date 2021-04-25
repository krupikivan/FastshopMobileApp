import 'package:fastshop_mobile/blocs/home/promo_bloc.dart';
import 'package:fastshop_mobile/models/models.dart';
import 'package:fastshop_mobile/widgets/promo_card_widget.dart';
import 'package:flutter/material.dart';

class ActiveOfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllTodo();
    return Scaffold(
      body: StreamBuilder(
        //Estamos escuchando al stream,
        //cuando el valor sale afuera del stream largamos la lista por pantalla
        stream: bloc.allTodo,
        builder: (context, AsyncSnapshot<List<Promocion>> snapshot) {
          if (snapshot.hasData) {
            //Aca largamos la lista a la pantalla
            return snapshot.data.length == 0
                ? Center(child: Text('No hay promociones'))
                : buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text('Error es:${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Promocion>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          enableFeedback: true,
          child: new PromoCard(
              title: snapshot.data[index].promocion +
                  ' en ' +
                  snapshot.data[index].producto,
              date: 'Del ' +
                  snapshot.data[index].fechaInicio +
                  ' al ' +
                  snapshot.data[index].fechaFin),
        );
      },
    );
  }
}

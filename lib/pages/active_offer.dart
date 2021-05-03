import 'package:fastshop/blocs/home/promo_bloc.dart';
import 'package:fastshop/models/models.dart';
import 'package:fastshop/widgets/promo_card_widget.dart';
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
                ? Center(
                    child: Text('Sin promociones',
                        style: Theme.of(context).textTheme.display1))
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
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          enableFeedback: true,
          child: new PromoCard(promocion: snapshot.data[index]),
        );
      },
    );
  }
}

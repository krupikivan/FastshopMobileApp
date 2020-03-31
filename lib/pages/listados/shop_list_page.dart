import 'package:fastshop_mobile/design/colors.dart';
import 'package:fastshop_mobile/functions/getUsername.dart';
import 'package:fastshop_mobile/models/models.dart';
import 'package:fastshop_mobile/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fastshop_mobile/blocs/listados/listado_bloc.dart';

import 'package:fastshop_mobile/pages/listados/shop_details_list_page.dart';
import 'package:provider/provider.dart';

class ShopListPage extends StatelessWidget {
  // var user

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserRepository>(context, listen: false);
    bloc_user_list.fetchUserListNames(userData.userData.idCliente);
    // fetchUserListNames(userData.userData.idCliente);
    return StreamBuilder(
      //Estamos escuchando al stream,
      //cuando el valor sale afuera del stream largamos la lista por pantalla
      stream: bloc_user_list.userListNames,
      builder: (context, AsyncSnapshot<List<Listado>> snapshot) {
        if (snapshot.hasData) {
          //Aca largamos la lista a la pantalla
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text('Error es:${snapshot.error}');
        }
        return Center(child:Text('Sin listados', style: Theme.of(context).textTheme.display1),);
      },
    );
    //floatingActionButton: FloatingActionButton.extended(onPressed: null, backgroundColor: Colors.blueAccent, icon: Icon(Icons.add), label: Text('Nuevo'))
  }

  Widget buildList(AsyncSnapshot<List<Listado>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
            enableFeedback: true,
            child: Card(
              color: new Color(fCardColor.value),
              child: new Stack(
                children: <Widget>[
                  //new Image.network(snapshot.data[index].uri, fit: BoxFit.cover),
                  Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                      child: new Text(snapshot.data[index].nombre,
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black45))),
                ],
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
            ),
            onTap: () {
              Navigator.push( context,
                MaterialPageRoute(
                  builder: (context) => ShopDetailsListPage(
                      nombre: snapshot.data[index].nombre,
                      idListado: snapshot.data[index].idListado),
                ),
              );
            });
      },
    );
  }
}
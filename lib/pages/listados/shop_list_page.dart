import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fastshop/blocs/listados/listado_bloc.dart';

import 'package:fastshop/pages/listados/shop_details_list_page.dart';

class ShopListPage extends StatelessWidget {
  // var user

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartBloc>(context);

    // fetchUserListNames(userData.userData.idCliente);
    if (cart.isBuying && blocUserList.selected != null) {
      blocUserList.fetchListCategories(blocUserList.selected.idListado);
      return StreamBuilder(
        stream: blocUserList.listCategoryName,
        builder: (context, AsyncSnapshot<List<ListCategory>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text(
                  "Listado: ${blocUserList.selected.nombre}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(snapshot.data[index].descripcion),
                              trailing: cart.checkCategoryIncluded(
                                      snapshot.data[index].idCategoria)
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : SizedBox.shrink(),
                            ),
                            Divider(
                              color: Colors.black45,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error es:${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    } else {
      blocUserList.fetchUserListNames();

      return StreamBuilder(
        //Estamos escuchando al stream,
        //cuando el valor sale afuera del stream largamos la lista por pantalla
        stream: blocUserList.userListNames,
        builder: (context, AsyncSnapshot<List<Listado>> snapshot) {
          if (snapshot.hasData) {
            //Aca largamos la lista a la pantalla
            if (snapshot.data.isEmpty) {
              return Text('Sin listados',
                  style: Theme.of(context).textTheme.headline4);
            } else {
              return buildList(snapshot.data);
            }
          } else if (snapshot.hasError) {
            return Text('Error es:${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    }
    //floatingActionButton: FloatingActionButton.extended(onPressed: null, backgroundColor: Colors.blueAccent, icon: Icon(Icons.add), label: Text('Nuevo'))
  }

  Widget buildList(List<Listado> data) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
            enableFeedback: true,
            child: Card(
              color: new Color(fPromoCardBackColor.value),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: new Text(data[index].nombre,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopDetailsListPage(
                      nombre: data[index].nombre,
                      idListado: data[index].idListado),
                ),
              );
            });
      },
    );
  }
}

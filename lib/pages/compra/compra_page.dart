import 'package:fastshop/blocs/compra/compra_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/compra.dart';
import 'package:fastshop/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompraPage extends StatelessWidget {
  // var user

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserRepository>(context, listen: false);
    blocCompra.fetchCompras(userData.userData.idCliente);
    return StreamBuilder(
      stream: blocCompra.compraList,
      builder: (context, AsyncSnapshot<List<Compra>> snapshot) {
        if (snapshot.hasData) {
          //Aca largamos la lista a la pantalla
          if (snapshot.data.isEmpty) {
            return Text('Sin Compras',
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
    //floatingActionButton: FloatingActionButton.extended(onPressed: null, backgroundColor: Colors.blueAccent, icon: Icon(Icons.add), label: Text('Nuevo'))
  }

  Widget buildList(List<Compra> data) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
            enableFeedback: true,
            child: Card(
              color: new Color(fPromoCardBackColor.value),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Text(
                        'Fecha: ' + data[index].fecha,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      new Text(
                        'Cantidad de productos: ' +
                            data[index].cantidad.toString(),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      new Text(
                        'Total: \$' + data[index].total.toString(),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ShopDetailsListPage(
              //         nombre: data[index].nombre,
              //         idListado: data[index].idListado),
              //   ),
              // );
            });
      },
    );
  }
}

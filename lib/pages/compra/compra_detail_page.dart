import 'package:fastshop/blocs/compra/compra_bloc.dart';
import 'package:fastshop/models/detalle_compra.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompraDetailPage extends StatelessWidget {
  final int id;

  const CompraDetailPage({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    blocCompra.fetchCompraDetalle(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Compra',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
        stream: blocCompra.detalle,
        builder: (context, AsyncSnapshot<List<DetalleCompra>> snapshot) {
          if (snapshot.hasData) {
            //Aca largamos la lista a la pantalla
            if (!snapshot.hasData) {
              return Text('Sin Compra',
                  style: Theme.of(context).textTheme.headline4);
            } else {
              return buildList(snapshot.data);
            }
          } else if (snapshot.hasError) {
            return Text('Error es:${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
    //floatingActionButton: FloatingActionButton.extended(onPressed: null, backgroundColor: Colors.blueAccent, icon: Icon(Icons.add), label: Text('Nuevo'))
  }

  Widget buildList(List<DetalleCompra> data) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 1,
                child: ListTile(
                  isThreeLine: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data[index].descripcion),
                      Text('Unidades: ' + data[index].cantidad.toString()),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Text(
                              '\$${num.parse((data[index].monto).toStringAsFixed(2))}',
                              style: TextStyle(
                                  fontSize: data[index].hasPromo ? 10 : 15,
                                  fontWeight: data[index].hasPromo
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  decoration: data[index].hasPromo
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none)),
                          data[index].hasPromo
                              ? Positioned(
                                  top: 10,
                                  right: 2,
                                  child: FittedBox(
                                    child: Text(
                                      '\$${num.parse((data[index].total).toStringAsFixed(2))}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                    ],
                  ),
                  subtitle: data[index].descuento == 0
                      ? Text('')
                      : Text(
                          'Descuento: \$' + data[index].descuento.toString()),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.only(bottom: 30, top: 10),
          width: double.infinity,
          child: Center(
            child: Text(
              "Total: \$${num.parse(data[0].totalCompra.toStringAsFixed(2))}",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}

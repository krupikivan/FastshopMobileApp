import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/listados/listado_bloc.dart';
import 'package:fastshop/blocs/listados/listado_event.dart';
import 'package:fastshop/blocs/listados/listado_state.dart';
import 'package:fastshop/blocs/listados/listado_delete_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/models.dart';
import 'package:fastshop/pages/home_page.dart';
import 'package:flutter/material.dart';

class ShopDetailsListPage extends StatelessWidget {
  final nombre;
  final idListado;

  ListadoDeleteBloc _listadoStateBloc;

  ShopDetailsListPage({
    this.nombre,
    this.idListado,
  });

  @override
  Widget build(BuildContext context) {
    blocUserList.fetchListCategories(idListado);
    _listadoStateBloc = ListadoDeleteBloc();
    return BlocEventStateBuilder<ListadoState>(
        bloc: _listadoStateBloc,
        builder: (BuildContext context, ListadoState state) {
          if (state.isRunning) {
            return _buildNormal(context);
          } else if (state.isSuccess) {
            return _buildSuccess(context);
          } else if (state.isFailure) {
            return _buildFailure(context);
          }
          return _buildNormal(context);
        });
  }

  Widget _buildNormal(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(nombre,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
          child: StreamBuilder(
            //El stream que contiene las categorias del listado ya seleccionado
            stream: blocUserList.listCategoryName,
            builder: (context, AsyncSnapshot<List<ListCategory>> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text('Error es:${snapshot.error}');
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              deleteList(context);
            },
            backgroundColor: fPromoCardBackColor,
            icon: Icon(Icons.delete),
            label: Text('Eliminar')));
  }

  Widget buildList(AsyncSnapshot<List<ListCategory>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: Column(
              children: [
                ListTile(
                  title: Text(snapshot.data[index].descripcion),
                ),
                Divider(
                  color: Colors.black45,
                )
              ],
            ),
          );
        });
  }

  Widget _buildSuccess(BuildContext context) {
    return AlertDialog(
      title: Text('Exitoso'),
      content: const Text('El listado se ha eliminado con exito'),
      actions: <Widget>[
        OutlinedButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          index: 3,
                        )));
          },
        ),
      ],
    );
  }

  Widget _buildFailure(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: const Text('Error en la eliminacion del listado'),
      actions: <Widget>[
        OutlinedButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  deleteList(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar listado'),
          content: Text('Seguro quiere eliminar el listado ' + nombre + '?'),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('Si'),
              onPressed: () {
                _deleteListById(idListado);
                Navigator.pop(context);
              },
            ),
            OutlinedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteListById(int idListado) {
    _listadoStateBloc.emitEvent(ListDelete(
        event: ListadoEventType.working, idList: idListado.toString()));
  }
}

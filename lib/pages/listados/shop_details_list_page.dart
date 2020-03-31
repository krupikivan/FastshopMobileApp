import 'package:fastshop_mobile/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop_mobile/blocs/listados/listado_bloc.dart';
import 'package:fastshop_mobile/blocs/listados/listado_event.dart';
import 'package:fastshop_mobile/blocs/listados/listado_state.dart';
import 'package:fastshop_mobile/blocs/listados/listado_delete_bloc.dart';
import 'package:fastshop_mobile/models/models.dart';
import 'package:fastshop_mobile/pages/home_page.dart';
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
    bloc_user_list.fetchListCategories(idListado);
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

  Widget _buildNormal(BuildContext context){
    return Scaffold(
        body: Container(
          child: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text(nombre, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  expandedHeight: 5.0,
                  floating: false,
                  backgroundColor: Colors.black45,
                  pinned: false,
                  elevation: 0.0,
                ),
              ];
            },
            body: StreamBuilder(
              //El stream que contiene las categorias del listado ya seleccionado
              stream: bloc_user_list.listCategoryName,
              builder: (context,
                  AsyncSnapshot<List<ListCategory>> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                }
                else if (snapshot.hasError) {
                  return Text('Error es:${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          margin: new EdgeInsets.only(bottom: 10.0),
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){deleteList(context);}, backgroundColor: Colors.red, icon: Icon(Icons.delete), label: Text('Eliminar'))
    );
  }

  Widget buildList(AsyncSnapshot<List<ListCategory>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: ListTile(
              title: Text(snapshot.data[index].descripcion),
            ),
          );
        }
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return AlertDialog(
      title: Text('Exitoso'),
      content: const Text('El listado se ha eliminado con exito'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(index: 3,)));
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
        FlatButton(
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
          content: Text(
              'Seguro quiere eliminar el listado ' + nombre + '?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Si'),
              onPressed: () {
                _deleteListById(idListado);
                Navigator.pop(context);
              },
            ),
            FlatButton(
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

  void _deleteListById(idListado) {
    _listadoStateBloc.emitEvent(ListDelete(
        event: ListadoEventType.working,
        idList: idListado
    ));
  }
}

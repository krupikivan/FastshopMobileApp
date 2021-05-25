import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop/blocs/listados/listado_event.dart';
import 'package:fastshop/blocs/listados/listado_save_bloc.dart';
import 'package:fastshop/blocs/listados/listado_state.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/functions/getUsername.dart';
import 'package:fastshop/models/models.dart';
import 'package:fastshop/pages/home_page.dart';
import 'package:fastshop/pages/listados/list_categoria_notifier.dart';
import 'package:fastshop/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateListPage extends StatefulWidget {
  // final List<Categoria> selected;

  // CreateListPage({
  //   this.selected,
  // });

  @override
  State<StatefulWidget> createState() {
    return CreateListPageState(
        // selected: selected,
        );
  }
}

class CreateListPageState extends State<CreateListPage> {
  // final List<Categoria> selected;
  TextEditingController listNameController = new TextEditingController();
  String msg = '';
  ListSaveBloc _listStateBloc;

  // var user;
  // Future<void> _getUsername() async {
  //   user = await getUsername();
  // }

  // CreateListPageState({
  //   this.selected,
  // });

  @override
  void initState() {
    // _getUsername();
    _listStateBloc = ListSaveBloc();
    super.initState();
  }

  @override
  void dispose() {
    _listStateBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<ListCategoriaNotifier>(context);
    return BlocEventStateBuilder<ListadoState>(
        bloc: _listStateBloc,
        builder: (BuildContext context, ListadoState state) {
          if (state.isRunning) {
            return _buildNormal(context);
          } else if (state.isSuccess) {
            list.listCategoria = [];
            return _buildSuccess();
          } else if (state.isFailure) {
            return _buildFailure();
          }
          return _buildNormal(context);
        });
  }

  Widget _buildNormal(BuildContext context) {
    AuthenticationBloc user = BlocProvider.of<AuthenticationBloc>(context);
    var list = Provider.of<ListCategoriaNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Nuevo listado',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          top: false,
          bottom: true,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  child: TextField(
                    controller: listNameController,
                    decoration: InputDecoration(
                        hintText: "Ingrese nombre del listado",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                  padding: const EdgeInsets.all(15.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    msg,
                    style: TextStyle(fontSize: 15.0, color: Colors.red),
                  ),
                ),
                new Expanded(
                  child: new ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: list.listCategoria.length,
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return new Column(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new ListTile(
                                trailing: InkWell(
                                    onTap: () {
                                      setState(() {
                                        list.removeToList(
                                            list.listCategoria[index]);
                                      });
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: fPromoCardBackColor,
                                      size: 35.0,
                                    )),
                                title:
                                    Text(list.listCategoria[index].descripcion),
                              ),
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              saveList(user);
            },
            backgroundColor: primaryColor,
            icon: Icon(Icons.save),
            label: Text('Guardar')));
  }

  Future<void> saveList(user) async {
    var list = Provider.of<ListCategoriaNotifier>(context, listen: false);
    if (list.listCategoria.isEmpty || listNameController.text == "") {
      if (list.listCategoria.isEmpty) {
        return showDialog(
          context: context,
          barrierDismissible: false, // user must tap button for close dialog!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error!'),
              content: const Text('No selecciono ningun elemento para guardar'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        return showDialog(
          context: context,
          barrierDismissible: false, // user must tap button for close dialog!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error!'),
              content: const Text('Debe ingresar un nombre al listado'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      _insertNewList(user, list);
      await new Future.delayed(const Duration(seconds: 2));
      /*Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return InsertList(
            name: listNameController.text,
            selected: selected,
          );
        }),);*/
    }
  }

  void _insertNewList(AuthenticationBloc user, list) async {
    _listStateBloc.emitEvent(ListSave(
        event: ListadoEventType.savingList,
        selected: list.listCategoria,
        name: listNameController.text,
        user: user.userRepository.userData));
  }

  Widget _buildSuccess() {
    return AlertDialog(
      title: Text('Muy bien!'),
      content: Text('Se creo ' + listNameController.text),
      actions: <Widget>[
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          index: 1,
                        )));
          },
        ),
      ],
    );
  }

  Widget _buildFailure() {
    return AlertDialog(
      title: Text('Error!'),
      content: const Text('Error en creacion del listado'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

import 'dart:async';
import 'package:fastshop_mobile/models/models.dart';
import 'package:fastshop_mobile/repos/listado_provider.dart';

class ListadoRepository{

  //final title = '';
  final listProvider = ListadoProvider();

  //Enviamos el usuario por parametro y llamamos al proveedor de la API
  Future<List<Listado>> fetchListNames(user) => listProvider.fetchUserListNames(user);

  //Future<List<Listado>> fetchExistList(idListado) => listProvider.fetchExistList(idListado);

  //Enviamos el id del listado y traemos las categorias que tiene para mostrar
  Future<List<ListCategory>> fetchListCategories(id) => listProvider.fetchListCategoryNames(id);

  //Future<List<Listado>> addSaveList(String nombre, List<Categoria> selected, var user) => listProvider.addList(nombre, selected, user);
  //Borrar el listado por ID
  //Future<List<Listado>> deleteList(idListado) => listProvider.deleteList(idListado);
//Future updateTodo(String ids) => listadoProvider.updateInsert(ids);


}
import 'dart:async';
import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/listado_provider.dart';

class ListadoRepository {
  //final title = '';
  final listProvider = ListadoProvider();

  //Enviamos el usuario por parametro y llamamos al proveedor de la API
  Future<List<Listado>> fetchListNames() => listProvider.fetchUserListNames();

  //Enviamos el id del listado y traemos las categorias que tiene para mostrar
  Future<List<ListCategory>> fetchListCategories(id) =>
      listProvider.fetchListCategoryNames(id);
}

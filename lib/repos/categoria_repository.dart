import 'dart:async';

import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/categoria_provider.dart';

class CategoriaRepository {
  //---------------CATEGORIA------------------------------------------
  //final title = '';
  final categoriaProvider = CategoriaProvider();

  Future<List<Categoria>> fetchAllTodo() => categoriaProvider.fetchTodoList();
  Future addSaveTodo(String title) => categoriaProvider.addTodo(title);
//Future updateSaveTodo(String ids) => categoriaProvider.updateTodo(ids);

//---------------CATEGORIA------------------------------------------

}

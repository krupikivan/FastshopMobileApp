import 'dart:async';

import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/promo_provider.dart';

class PromoRepository {
  //---------------PROMOCION------------------------------------------
  //final title = '';
  final promoProvider = PromoProvider();

  Future<List<Promocion>> fetchAllTodo() => promoProvider.fetchTodoList();
  Future addSaveTodo(String title) => promoProvider.addTodo(title);
  Future updateSaveTodo(String ids) => promoProvider.updateTodo(ids);

//---------------PROMOCION------------------------------------------

}

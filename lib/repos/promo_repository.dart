import 'dart:async';

import 'package:fastshop_mobile/models/models.dart';
import 'package:fastshop_mobile/repos/promo_provider.dart';

class PromoRepository{

  //---------------PROMOCION------------------------------------------
  //final title = '';
  final promoProvider = PromoProvider();

  Future<List<Promocion>> fetchAllTodo() => promoProvider.fetchTodoList();
  Future addSaveTodo(String title) => promoProvider.addTodo(title);
  Future updateSaveTodo(String ids) => promoProvider.updateTodo(ids);

//---------------PROMOCION------------------------------------------

}
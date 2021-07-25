import 'dart:async';
import 'package:fastshop/models/notificacion.dart';
import 'package:fastshop/repos/notif_provider.dart';

class NotificationRepository {
  //---------------PROMOCION------------------------------------------
  //final title = '';
  final notifProvider = NotifProvider();

  Future<List<Notificacion>> fetchAllTodo() => notifProvider.fetchTodoList();

//---------------PROMOCION------------------------------------------

}

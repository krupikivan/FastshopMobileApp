import 'package:fastshop/models/notificacion.dart';
import 'package:fastshop/preferences.dart';
import 'package:fastshop/repos/notif_repository.dart';
import 'package:flutter/material.dart';

class NotificationBloc with ChangeNotifier {
  final _repository = NotificationRepository();
  List<Notificacion> _notifications = [];
  bool _loading = false;
  bool get loading => _loading;
  List<Notificacion> get notifications => _notifications;

  NotificationBloc.init() {
    getNotif();
  }

  set notifications(List list) {
    _notifications = list;
    notifyListeners();
  }

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  //Con stream escuchamos y con sink agregamos (es como una pila)
  // Observable<List<Promocion>> get allTodo => _todoFetcher.stream;

  getNotif() async {
    print("Trayendo notificaciones");
    _loading = true;
    notifyListeners();
    List list = await _repository.fetchAllTodo();
    notifications = list;
    _loading = false;
  }

  bool hasUnreadNotif() {
    // notifyListeners();
    if (Preferences().notif.length != _notifications.length) {
      return true;
    } else {
      return false;
    }
  }

  saveData() {
    List<String> list = [];
    notifications.forEach((e) {
      list.add(e.id);
    });
    Preferences().notif = list;
  }
}

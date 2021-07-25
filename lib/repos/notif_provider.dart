import 'package:fastshop/connection.dart';
import 'package:fastshop/models/notificacion.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class NotifProvider {
  Client client = Client();
  final _url = 'http://' + con.getUrl() + '/notificacion/read.php';

  Future<List<Notificacion>> fetchTodoList() async {
    final response = await client.get(_url);
    if (response.statusCode == 200) {
      var res = await compute(notificacionFromJson, response.body);

      return res;
      // return Promocion.fromJson(json.decode(response.body));
    } else {
      return [];
    }
  }
}

import 'package:fastshop/connection.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class PromoProvider {
  Client client = Client();
  final _url = 'http://' + con.getUrl() + '/promocion/read.php';
  Future<List<Promocion>> fetchTodoList() async {
    final response = await client.get(_url);
    if (response.statusCode == 200) {
      var res = await compute(promocionFromJson, response.body);

      return res;
      // return Promocion.fromJson(json.decode(response.body));
    } else {
      return [];
    }
  }

  Future addTodo(title) async {
    final response = await client.post("$_url/create", body: {'name': title});
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Error en cargar datos');
    }
  }

  Future updateTodo(ids) async {
    // print('$_url$ids/update');
    final response =
        await client.put("$_url$ids/update", body: {'done': "true"});
    if (response.statusCode == 200) {
      print('berhasil di update');
      return response;
    } else {
      throw Exception('Failed to update data');
    }
  }
}

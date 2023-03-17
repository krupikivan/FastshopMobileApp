import 'dart:convert';
import 'package:fastshop/connection.dart';
import 'package:fastshop/models/compra.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class CompraProvider {
  Client client = Client();
  Compra listadoNuevo = Compra();

  //URL para traer los nombres de los listados del cliente logueado
  final _url = con.getUrl() + '/compra/readCliente.php';
  final _urlNew = con.getUrl() + '/compra/insertCompra.php';

  var headers = {"accept": "application/json"};

  //Este es nuestro metodo para mandarle el usuario activo y que devuelva los nombres de los listados
  Future<List<Compra>> fetchUserCompras(int id) async {
    final response = await client.get(_url + "?idCliente=$id");
    if (response.statusCode == 200) {
      print(response.body);
      return await compute(listadoFromJson, response.body);
    } else {
      print('No encontro compras');
      return [];
      // throw Exception('No encontro listado de compras');
    }
  }

  //Para agregar el nombre de una lista de compra (PRIMERA TABLA)
  Future<List<Compra>> saveCompra(List<int> list, int idCliente) async {
    var body = {
      'idCliente': idCliente,
      'listadoProductos': list,
    };
    print(jsonEncode(body));
    final response = await client.post(_urlNew, body: jsonEncode(body));
    if (response.statusCode == 200) {
      // List<Listado> listado = listadoFromJson(response.body);
      // listCat = listadoXCategoria.createListXCate(listado[0].idListado, selected);
      // await addCategories(listCat, user);
      // String idCliente = await getIdClien(user);
      // await addListXClien(listado[0].idListado, idCliente);
      // return listado;
    } else {
      throw new Exception('Error!');
    }
  }
}

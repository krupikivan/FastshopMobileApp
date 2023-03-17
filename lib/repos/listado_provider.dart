import 'dart:convert';
import 'package:fastshop/connection.dart';
import 'package:fastshop/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class ListadoProvider {
  Client client = Client();
  Listado listadoNuevo = Listado();
  ListadoXCategoria listadoXCategoria = ListadoXCategoria();
  List<ListadoXCategoria> listCat;
  Categoria categoria = Categoria();

  //URL para traer los nombres de los listados del cliente logueado
  final _url = con.getUrl() + '/listado/readListName.php';
  final _urlCategory = con.getUrl() + '/listado/readListCategoryName.php';
  final _urlNewList = con.getUrl() + '/listado/insertListado.php';
  final _urlInsertCat = con.getUrl() + '/listado/insertListadoSubcategoria.php';
  final _urlInsertListXClie =
      con.getUrl() + '/listado/insertListadoXCliente.php';
  final _urlGetIdUser = con.getUrl() + '/cliente/readIdcliente.php';
  final _urlExistList = con.getUrl() + '/listado/getListExist.php';
  final _urlDeleteList = con.getUrl() + '/listado/deleteListadoCompra.php';

  var headers = {"accept": "application/json"};

  //Este es nuestro metodo para mandarle el usuario activo y que devuelva los nombres de los listados
  Future<List<Listado>> fetchUserListNames(var id) async {
    final response = await client.get(_url + "?idCliente=$id");
    if (response.statusCode == 200) {
      print(response.body);
      return await compute(listadoFromJson, response.body);
    } else {
      print('No encontro listados');
      return [];
      // throw Exception('No encontro listado de compras');
    }
  }

  //Este es nuestro metodo para mandarle el id de la lista seleccionada y que devuelva los productos
  Future<List<ListCategory>> fetchListCategoryNames(var id) async {
    final response = await client.get(_urlCategory + "?idListado=$id");
    print(response.body);
    if (response.statusCode == 200) {
      return compute(listCategoriesFromJson, response.body);
    } else {
      throw Exception('Error en carga');
    }
  }

  //Metodo para borrar el listado con sus 3 tablas
  // Future<List<Listado>> deleteList(idListado) async {
  //   final response = await client.post(_urlDeleteList+"?idListado=$idListado");
  //   if (response.statusCode == 200) {
  //     //Eliminado
  //   } else {
  //     throw new Exception('El listado no se borro!');
  //   }
  // }

  Future<bool> deleteUserList({
    @required String idListado,
  }) async {
    final response =
        await client.post(_urlDeleteList + "?idListado=$idListado");
    if (response.statusCode == 400) {
      return false;
    }
    return true;
  }

  //Para agregar el nombre de una lista de compra (PRIMERA TABLA)
  Future<List<Listado>> addList(nombre, selected, Cliente user) async {
    var body = {
      'idCliente': user.idCliente,
      'nombre': nombre,
      'listadoCategorias': listxCate(selected)
    };
    print(jsonEncode(body));
    final response = await client.post(_urlNewList, body: jsonEncode(body));
    if (response.statusCode == 200) {
      // List<Listado> listado = listadoFromJson(response.body);
      // listCat = listadoXCategoria.createListXCate(listado[0].idListado, selected);
      // await addCategories(listCat, user);
      // String idCliente = await getIdClien(user);
      // await addListXClien(listado[0].idListado, idCliente);
      // return listado;
    } else {
      throw new Exception('El nombre ya existe!');
    }
  }

  //Luego de agregar el nombre, agregamos las categorias de una lista de compra (SEGUNDA TABLA)
  Future addCategories(listCat, user) async {
    var body = jsonEncode(listCat);
    final response = await client.post(_urlInsertCat, body: body);
    if (response.statusCode == 200) {
      var id = jsonDecode(response.body);
      return id;
    } else {
      throw new Exception('No se agregaron categorias');
    }
  }

  //Luego de agregar las subcategorias agregamos el cliente con listado (TERCERA TABLA)
  Future<String> getIdClien(user) async {
    final responseId = await client.get(_urlGetIdUser + "?username=$user");
    if (responseId.statusCode == 200) {
      return jsonDecode(responseId.body);
    } else {
      throw new Exception('No se encontro el id');
    }
  }

  //Luego de agregar las subcategorias agregamos el cliente con listado (TERCERA TABLA)
  Future addListXClien(idListado, idCliente) async {
    var body = jsonEncode({'idListado': idListado, 'idCliente': idCliente});
    print(body);
    final response = await client.post(_urlInsertListXClie, body: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw new Exception('No se agregaron clientes x listados');
    }
  }

  Future<List<Listado>> fetchExistList(var idListado) async {
    final response = await client.get(_urlExistList + "?idListado=$idListado");
    if (response.statusCode == 200) {
      var exist = jsonDecode(response.body);
      return exist;
    } else {
      throw Exception('Verificar carga de usuario');
    }
  }
}

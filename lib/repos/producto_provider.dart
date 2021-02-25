import 'dart:convert';

import 'package:fastshop_mobile/connection.dart';
import 'package:fastshop_mobile/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class ProductoProvider {
  Client client = Client();
  final _url = 'http://' + con.getUrl() + '/producto/readProductList.php';
  final _urlScann = 'http://' + con.getUrl() + '/producto/readBarcode.php';

  Future<List<Producto>> fetchProductList() async {
    final response = await client.get(_url);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(productoFromJson, response.body);
    } else {
      throw Exception('Error en carga');
    }
  }

  Future<Producto> fetchProductScanned(barcode) async {
    final response = await client.get(_urlScann + "?codigo=$barcode");
    if (response.statusCode == 200) {
      Map productMap = jsonDecode(response.body);
      Producto p = Producto.fromJson(productMap);
      return p;
    } else {
      throw Exception('Error en carga');
    }
  }
}

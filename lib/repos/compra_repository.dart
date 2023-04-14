import 'dart:async';
import 'package:fastshop/models/compra.dart';
import 'package:fastshop/models/detalle_compra.dart';

import 'compra_provider.dart';

class CompraRepository {
  //final title = '';
  final listProvider = CompraProvider();

  //Enviamos el usuario por parametro y llamamos al proveedor de la API
  Future<List<Compra>> fetchCompras(int id) =>
      listProvider.fetchUserCompras(id);
  Future<List<DetalleCompra>> fetchDetalleCompras(int id) =>
      listProvider.fetchDetalleCompras(id);
  Future<void> saveCompra(List<int> list, int id) =>
      listProvider.saveCompra(list, id);
}

import 'dart:async';

import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/producto_provider.dart';

class ProductoRepository {
  final productoProvider = ProductoProvider();

  Future<List<Producto>> fetchProductList() =>
      productoProvider.fetchProductList();

  Future<Producto> fetchProductScanned(barcode) =>
      productoProvider.fetchProductScanned(barcode);
}

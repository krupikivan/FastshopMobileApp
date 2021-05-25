import 'package:fastshop/models/producto.dart';

class CartItem {
  final int count;
  final Producto product;
  bool hasPromo;
  double monto;

  CartItem({this.count, this.product, this.hasPromo = false, this.monto = 0});

  double get totalPrice => count * product.precio;

  @override
  String toString() => "${product.descripcion}: \$$count";
}

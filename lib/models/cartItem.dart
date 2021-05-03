import 'package:fastshop/models/producto.dart';

class CartItem {
  final int count;
  final Producto product;

  const CartItem(this.count, this.product);

  double get totalPrice => count * product.precio;

  @override
  String toString() => "${product.descripcion}: \$$count";
}

import 'package:fastshop/models/producto.dart';
import 'package:fastshop/models/promocion.dart';

class CartItem {
  int count;
  final Producto product;
  Promocion promo;

  CartItem({
    this.count = 1,
    this.product,
    this.promo,
  });

  bool get hasPromo => promo != null && promo.cantidadProductos <= count;
  double get totalPrice => count * product.precio;
  double get promoPrice {
    if (promo != null) {
      var discountedItemCount =
          (count ~/ promo.cantidadProductos) * promo.cantidadProductos;
      var discountedAmount =
          discountedItemCount * product.precio * promo.formula;
      return totalPrice - discountedAmount;
    }
    return totalPrice;
  }

  @override
  String toString() => "${product.descripcion}: \$$count";
}

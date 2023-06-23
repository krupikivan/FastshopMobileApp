import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/cart.dart';
import 'package:fastshop/models/cartItem.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/models/promocion.dart';
import 'package:rxdart/subjects.dart';

class CartBloc implements BlocBase {
  final BehaviorSubject<List<CartItem>> _items =
      BehaviorSubject<List<CartItem>>.seeded([]);
  final List<CartItem> cartItemList = [];
  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);
  CartBloc();
  bool isBuying = false;
  setPromoItem(Producto producto, Promocion promo) {
    final cartItem = cartItemList
        .firstWhere((e) => e.product.idProducto == producto.idProducto);
    final index = cartItemList
        .indexWhere((e) => e.product.idProducto == producto.idProducto);
    cartItemList.remove(cartItem);
    cartItem.promo = promo;
    cartItemList.insert(index, cartItem);
    _items.add(cartItemList);
  }

  Promocion getPromoFromProduct(Producto producto, List<Promocion> list) {
    list.forEach((e) {
      if (e.idProducto == producto.idProducto) {
        return e;
      } else if (e.idCategoria == producto.idCategoria) {
        return e;
      }
    });
    return null;
  }

  double _calculateTotalPrice(Cart cart, List<Promocion> list) {
    double total = 0;
    cart.items.forEach((e) {
      bool isPromo =
          list.where((p) => p.producto == e.product.descripcion).isNotEmpty;
      print('La cantidad es: ' + e.count.toString());
      if (isPromo && e.count > 1) {
        if (e.count % 2 == 0) {
          total += e.product.precio * e.count * 0.5;
        } else {
          total += (e.product.precio * (e.count - 1) * 0.5) + e.product.precio;
        }
      } else {
        total += e.product.precio * e.count;
      }
    });
    return total;
  }

  void removeItem(Producto product) {
    final cartAddItem = cartItemList.firstWhere((e) => e.product == product);
    cartItemList.remove(cartAddItem);
    _items.add(cartItemList);
    _itemCount.add(cartItemList.fold(0, (p, e) => p + e.count));
    if (cartItemList.isEmpty) {
      isBuying = false;
    }
  }

  List<int> get productsId =>
      cartItemList.map((e) => e.product.idProducto).toList();

  double get totalPrice {
    double total = 0;
    cartItemList.forEach((e) {
      total += e.promoPrice;
    });
    return total;
  }

  void removeAll() {
    isBuying = false;
    cartItemList.clear();
    _itemCount.add(0);
  }

  void updateCount(Producto product, int value) {
    final cartItem = cartItemList.firstWhere((e) => e.product == product);
    final index = cartItemList.indexWhere((e) => e.product == product);
    cartItem.count = value;
    cartItemList.remove(cartItem);
    cartItemList.insert(index, cartItem);
    _items.add(cartItemList);
    _itemCount.add(cartItemList.fold(0, (p, e) => p + e.count));
  }

  void addUpdateCart(Producto product) {
    final exist = cartItemList.where((e) => e.product == product).isNotEmpty;
    if (exist) {
      final cartItem = cartItemList.firstWhere((e) => e.product == product);
      final index = cartItemList.indexWhere((e) => e.product == product);
      cartItemList.remove(cartItem);
      cartItem.count++;
      cartItemList.insert(index, cartItem);
    } else {
      cartItemList.add(CartItem(product: product));
    }
    _items.add(cartItemList);
    _itemCount.add(cartItemList.fold(0, (p, e) => p + e.count));
    isBuying = true;
  }

  bool checkCategoryIncluded(String idCategoria) {
    return cartItemList
        .where((e) => e.product.idCategoria == int.parse(idCategoria))
        .isNotEmpty;
  }

  List<Promocion> promos = [];

  Stream<int> get itemCount => _itemCount.stream;
  Stream<List<CartItem>> get items => _items.stream;

  @override
  void dispose() {
    _items.close();
    _itemCount.close();
  }
}

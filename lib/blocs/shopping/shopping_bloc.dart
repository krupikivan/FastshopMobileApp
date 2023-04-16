import 'dart:async';
import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/repos/producto_repository.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase {
  final _repo = ProductoRepository();
  CartBloc _cartBloc;

  BehaviorSubject<List<Producto>> _itemsController =
      BehaviorSubject<List<Producto>>();
  Stream<List<Producto>> get items => _itemsController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<Producto>> _shoppingBasketController =
      BehaviorSubject<List<Producto>>.seeded(<Producto>[]);
  Stream<List<Producto>> get shoppingBasket => _shoppingBasketController;

  @override
  void dispose() {
    _itemsController?.close();
    _shoppingBasketController?.close();
  }

  // Constructor
  ShoppingBloc() {
    // _loadShoppingItems();
  }

  void addScanProduct(barcode) async {
    Producto producto = await _repo.fetchProductScanned(barcode);
    _cartBloc.addUpdateCart(producto);
  }

  // void _loadShoppingItems() async {
  //   List<Producto> _productList = await _repo.fetchProductList();
  //   _itemsController.sink.add(_productList);
  // }
}

import 'package:fastshop_mobile/bloc_helpers/bloc_provider.dart';
import 'package:fastshop_mobile/models/producto.dart';

class CartItemBloc implements BlocBase {

  @override
  void dispose() {
    /// TODO:implement dispose
  }

  CartItemBloc(Producto shoppingItem);
}
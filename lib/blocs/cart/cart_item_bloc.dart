import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/models/producto.dart';

class CartItemBloc implements BlocBase {
  @override
  void dispose() {
    /// TODO:implement dispose
  }

  CartItemBloc(Producto shoppingItem);
}

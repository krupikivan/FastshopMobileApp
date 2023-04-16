import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/cartItem.dart';
import 'package:fastshop/models/promocion.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ItemTile extends StatelessWidget {
  ItemTile({this.item, this.promocion});
  final CartItem item;
  final List<Promocion> promocion;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        isThreeLine: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item.product.descripcion),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                    '\$${num.parse((item.product.precio * item.count).toStringAsFixed(2))}',
                    style: TextStyle(
                        fontSize: item.hasPromo ? 10 : 15,
                        fontWeight:
                            item.hasPromo ? FontWeight.normal : FontWeight.bold,
                        decoration: item.hasPromo
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
                item.hasPromo
                    ? Positioned(
                        top: 10,
                        right: 2,
                        child: FittedBox(
                          child: Text(
                            '\$${num.parse((item.promoPrice).toStringAsFixed(2))}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _showDialog(context);
              },
              child: Text('\nCantidad ${item.count}',
                  style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline)),
            ),
            Text('\nPrec/U. \$${item.product.precio}'),
          ],
        ),
        trailing: Container(
          child: _buildRemoveFromShoppingBasket(context),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            initialIntegerValue: item.count,
            minValue: 1,
            maxValue: 100,
            title: Text('Elige una cantidad'),
          );
        }).then((int value) {
      if (value != null) {
        cartBloc.updateCount(item.product, value);
      }
    });
  }

  Widget _buildRemoveFromShoppingBasket(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    return IconButton(
      icon: Icon(
        Icons.remove_circle_outline,
        color: fPromoCardBackColor,
      ),
      onPressed: () {
        cartBloc.removeItem(item.product);
      },
    );
  }
}

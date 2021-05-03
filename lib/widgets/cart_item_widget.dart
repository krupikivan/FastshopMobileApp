import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/models/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ItemTile extends StatelessWidget {
  ItemTile({this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        child: ListTile(
          isThreeLine: true,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item.product.descripcion),
                Text(
                    '\$${num.parse((item.product.precio * item.count).toStringAsFixed(2))}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
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
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
              ),
              Text('\nPrec/U. \$${item.product.precio}'),
            ],
          ),
          trailing: Container(
            child: _buildRemoveFromShoppingBasket(context),
          ),
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
        cartBloc.cartUpdate.add(CartAddition(item.product, value));
      }
    });
  }

  Widget _buildRemoveFromShoppingBasket(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    return IconButton(
      icon: Icon(
        Icons.remove_circle_outline,
        color: Colors.red,
      ),
      onPressed: () {
        cartBloc.cartAddition.add(CartAddition(item.product, -item.count));
      },
    );
  }
}

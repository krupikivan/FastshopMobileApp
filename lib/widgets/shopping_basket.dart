import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:flutter/material.dart';

class ShoppingBasket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartBloc bloc = BlocProvider.of<CartBloc>(context);
    return Container(
      width: 48.0,
      height: 48.0,
      child: Stack(
        children: <Widget>[
          Center(
            child: const Icon(Icons.shopping_basket),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(0.0, -5.0),
                child: StreamBuilder<int>(
                  //stream: bloc.shoppingBasketSize,
                  stream: bloc.itemCount,
                  initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    return Container(
                      width: 16.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: fPromoCardBackColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(
                          '${snapshot.data}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:barcode_scan/barcode_scan.dart';
import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/blocs/home/promo_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/models/promocion.dart';
import 'package:fastshop/repos/producto_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:fastshop/models/cartItem.dart';
import 'package:fastshop/widgets/cart_item_widget.dart';

class BlocCartPage extends StatefulWidget {
  BlocCartPage();
  @override
  State<StatefulWidget> createState() => BlocCartPageState();
}

class BlocCartPageState extends State<BlocCartPage> {
  String barcode = "";
  final _repo = ProductoRepository();

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartBloc>(context);
    return Scaffold(
        body: StreamBuilder<List<CartItem>>(
            stream: cart.items,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<PromoBloc>(
                      builder: (context, promoSnap, _) => InkWell(
                        onTap: () => scan(cart, _repo, promoSnap.promociones),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 140,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              Text(
                                "Escanear",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Consumer<PromoBloc>(
                      builder: (context, promoSnap, _) => Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: ListView(
                              children: snapshot.data
                                  .map((item) => ItemTile(
                                      item: item,
                                      promocion: promoSnap.promociones))
                                  .toList()),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: StreamBuilder<double>(
                              stream: cart.itemsTotalPrice,
                              initialData: 0,
                              builder: (context, snapshot) => Text(
                                "Total: \$${num.parse(snapshot.data.toStringAsFixed(2))}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 15),
                              ),
                            ),
                            subtitle: StreamBuilder<int>(
                              stream: cart.itemCount,
                              initialData: 0,
                              builder: (context, snapshot) => Text(
                                "Cant de prod.: ${snapshot.data}",
                                // style: TextStyle(
                                //     fontWeight: FontWeight.w900,
                                //     fontSize: 25),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () => _showQRCoder(context, cart),
                              child: Container(
                                height: 40,
                                width: 180,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text("Finalizar Compra",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Consumer<PromoBloc>(
                              builder: (context, promoSnap, _) =>
                                  FloatingActionButton.extended(
                                backgroundColor: primaryColor,
                                onPressed: () =>
                                    scan(cart, _repo, promoSnap.promociones),
                                label: Text("Escanear",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  void _showQRCoder(BuildContext context, CartBloc _cartBloc) {
    //Me soluciono el problema del layout
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Codigo QR para pagar'),
            content: Container(
              height: 0.5 * bodyHeight,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: RepaintBoundary(
                        child: QrImage(
                          data: "${_cartBloc.toString()}",
                          size: 0.5 * bodyHeight,
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          onError: (ex) {
                            print("[QR] ERROR - $ex");
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  Text('Muestre el codigo al cajero para realizar el pago.')
                ],
              ),
            ),
            actions: <Widget>[
              StreamBuilder<List<CartItem>>(
                  stream: _cartBloc.items,
                  builder: (context, snapshot) {
                    return OutlinedButton(
                        onPressed: () {
                          //Borra el carrito de compras
                          snapshot.data.forEach((element) {
                            _cartBloc.cartAddition.add(
                                CartAddition(element.product, -element.count));
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Finalizar'));
                  }),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Volver')),
            ],
          );
        });
  }

  Future scan(CartBloc _cartBloc, ProductoRepository _repo,
      List<Promocion> list) async {
    try {
      String barcode = await BarcodeScanner.scan();
      // String barcode = '7790895067556';
      print(barcode);
      Producto producto = await _repo.fetchProductScanned(barcode);
      _cartBloc.cartAddition.add(CartAddition(producto));
      List<int> _list = [];
      list.forEach((e) => _list.add(e.idProducto));
      if (_list.isNotEmpty && _list.contains(producto.idProducto)) {
        _cartBloc.setPromoItem(producto);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Producto con Promocion!'),
                content: Text(
                    'El producto escaneado ${producto.descripcion} tiene promocion asignada de tipo ${list.firstWhere((e) => e.idProducto == producto.idProducto).promocion}'),
                actions: <Widget>[
                  OutlinedButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
      // setState(() {
      //   this.barcode = barcode;
      //   bloc.addScanProduct(barcode);
      // });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Necesitamos acceso a la camara para continuar.';
        });
      } else {
        setState(() => this.barcode = 'Error desconocido: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Error desconocido: $e');
    }
  }
}

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/models/producto.dart';
import 'package:fastshop/repos/producto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => new _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String barcode = "";
  //TODO arreglar e implementar bloc en esta parte
  final _repo = ProductoRepository();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);
    return new Scaffold(
      body: Center(
        child: ButtonTheme(
          minWidth: 150.0,
          height: 50.0,
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/shoppingBasket');
            },
            label: Text(
              "Ir al carrito",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            scan(_cartBloc, _repo);
          },
          label: Text('Escanear'),
          icon: Icon(Icons.camera_alt)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future scan(CartBloc _cartBloc, ProductoRepository _repo) async {
    try {
      String barcode = await BarcodeScanner.scan();
      //TODO arreglar e implementar bloc en esta parte
      Producto producto = await _repo.fetchProductScanned(barcode);
      _cartBloc.cartAddition.add(CartAddition(producto));
      //TODO arreglar e implementar bloc en esta parte
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

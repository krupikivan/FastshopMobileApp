import 'package:fastshop/models/compra.dart';
import 'package:fastshop/models/detalle_compra.dart';
import 'package:fastshop/repos/compra_repository.dart';
import 'package:rxdart/rxdart.dart';

class CompraBloc {
  final _repository = CompraRepository();
  final _listFetcher = PublishSubject<List<Compra>>();
  final _detalle = PublishSubject<List<DetalleCompra>>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Compra>> get compraList => _listFetcher.stream;
  Observable<List<DetalleCompra>> get detalle => _detalle.stream;

  //Traemos los listados del usuario logueado
  fetchCompras(int idCliente) async {
    List<Compra> list = await _repository.fetchCompras(idCliente);
    _listFetcher.sink.add(list);
  }

  fetchCompraDetalle(int idCompra) async {
    List<DetalleCompra> value = await _repository.fetchDetalleCompras(idCompra);
    _detalle.sink.add(value);
  }

  saveCompras(List<int> list, int idCliente) async {
    if (list.isEmpty) return;
    await _repository.saveCompra(list, idCliente);
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async {
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    await _listFetcher.drain();
    _listFetcher.close();
    await _detalle.drain();
    _detalle.close();
  }
}

//Manejamos para traer los listados del cliente
final blocCompra = CompraBloc();

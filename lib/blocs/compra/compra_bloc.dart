import 'package:fastshop/models/compra.dart';
import 'package:fastshop/repos/compra_repository.dart';
import 'package:fastshop/repos/listado_repository.dart';
import 'package:fastshop/models/models.dart';
import 'package:rxdart/rxdart.dart';

class CompraBloc {
  final _repository = CompraRepository();
  final _listFetcher = PublishSubject<List<Compra>>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Compra>> get compraList => _listFetcher.stream;

  //Traemos los listados del usuario logueado
  fetchCompras(int idCliente) async {
    List<Compra> list = await _repository.fetchCompras(idCliente);
    _listFetcher.sink.add(list);
  }

  saveCompras(List<int> list, int idCliente) async {
    await _repository.saveCompra(list, idCliente);
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async {
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    await _listFetcher.drain();
    _listFetcher.close();
  }
}

//Manejamos para traer los listados del cliente
final blocCompra = CompraBloc();

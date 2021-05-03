import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/promo_repository.dart';
import 'package:rxdart/rxdart.dart';

class PromoBloc {
  final _repository = PromoRepository();
  final _todoFetcher = PublishSubject<List<Promocion>>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Promocion>> get allTodo => _todoFetcher.stream;

  fetchAllTodo() async {
    List<Promocion> promocion = await _repository.fetchAllTodo();
    _todoFetcher.sink.add(promocion);
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async {
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    await _todoFetcher.drain();
    _todoFetcher.close();
  }
}

final bloc = PromoBloc();

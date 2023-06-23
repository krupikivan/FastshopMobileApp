import 'package:fastshop/repos/listado_repository.dart';
import 'package:fastshop/models/models.dart';
import 'package:rxdart/rxdart.dart';

import '../../preferences.dart';

class ListBloc {
  final _listRepository = ListadoRepository();
  final _listFetcher = PublishSubject<List<Listado>>();
  final _categoriesFetcher = PublishSubject<List<ListCategory>>();
  Listado selected;
  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Listado>> get userListNames => _listFetcher.stream;

  Stream<List<Listado>> get list async* {
    List<Listado> list = await _listRepository.fetchListNames();
    yield list;
  }

  Observable<List<ListCategory>> get listCategoryName =>
      _categoriesFetcher.stream;

  //Traemos los listados del usuario logueado
  fetchUserListNames() async {
    try {
      List<Listado> list = await _listRepository.fetchListNames();
      _listFetcher.sink.add(list);
    } catch (_) {
      return;
    }
  }

  setListado(Listado listado) {
    selected = listado;
  }

  //Traemos las categorias del listado seleccionado
  fetchListCategories(var id) async {
    List<ListCategory> listCategories =
        await _listRepository.fetchListCategories(id);
    _categoriesFetcher.sink.add(listCategories);
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async {
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    await _listFetcher.drain();
    _listFetcher.close();

    await _categoriesFetcher.drain();
    _categoriesFetcher.close();
  }
}

//Manejamos para traer los listados del cliente
final blocUserList = ListBloc();

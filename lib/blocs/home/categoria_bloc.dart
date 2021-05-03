import 'package:fastshop/models/models.dart';
import 'package:fastshop/repos/categoria_repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final _repositoryCategory = CategoriaRepository();
  final _todoFetcher = PublishSubject<List<Categoria>>();

  //Con stream escuchamos y con sink agregamos (es como una pila)
  Observable<List<Categoria>> get allTodo => _todoFetcher.stream;

  fetchAllTodo() async {
    List<Categoria> categoria = await _repositoryCategory.fetchAllTodo();
    _todoFetcher.sink.add(categoria);
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  dispose() async {
    //Cerramos los stream para que no gaste recursos cuando no se estan usando
    await _todoFetcher.drain();
    _todoFetcher.close();
  }
}

final bloc_categories_name = CategoryBloc();

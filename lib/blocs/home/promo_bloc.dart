import 'package:fastshop/models/promocion.dart';
import 'package:fastshop/repos/promo_repository.dart';
import 'package:flutter/material.dart';

class PromoBloc with ChangeNotifier {
  final _repository = PromoRepository();
  // final _todoFetcher = PublishSubject<List<Promocion>>();
  List<Promocion> _promociones = [];
  bool _loading = false;
  bool firstLoading = true;
  bool get loading => _loading;
  List<Promocion> get promociones => _promociones;
  List<Promocion> get promocionesOrdered {
    List<Promocion> _ordered = List.from(_promociones);
    _ordered.sort((a, b) => a.prioridad.compareTo(b.prioridad));
    return _ordered;
  }

  PromoBloc.init() {
    getPromos();
  }

  set promociones(List list) {
    _promociones = list;
    notifyListeners();
  }

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  //Con stream escuchamos y con sink agregamos (es como una pila)
  // Observable<List<Promocion>> get allTodo => _todoFetcher.stream;

  getPromos() async {
    _loading = true;
    notifyListeners();
    List list = await _repository.fetchAllTodo();
    firstLoading = false;
    promociones = list;
    _loading = false;
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  // dispose() async {
  //Cerramos los stream para que no gaste recursos cuando no se estan usando
  // await _todoFetcher.drain();
  // _todoFetcher.close();
  // }
}

// final bloc = PromoBloc();

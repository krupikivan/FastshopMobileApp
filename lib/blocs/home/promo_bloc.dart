import 'package:fastshop/models/promocion.dart';
import 'package:fastshop/repos/promo_repository.dart';
import 'package:flutter/material.dart';

class PromoBloc with ChangeNotifier {
  final _repository = PromoRepository();
  // final _todoFetcher = PublishSubject<List<Promocion>>();
  List<Promocion> _promociones = [];

  List<Promocion> get promociones => _promociones;

  PromoBloc.init() {
    getPromos();
  }

  set promociones(List list) {
    _promociones = list;
    notifyListeners();
  }

  //Con stream escuchamos y con sink agregamos (es como una pila)
  // Observable<List<Promocion>> get allTodo => _todoFetcher.stream;

  getPromos() async {
    List list = await _repository.fetchAllTodo();
    promociones = list;
  }

  //El ASYNC soluciono el tema de cambiar de pestaña y volver para que siga estando
  // dispose() async {
  //Cerramos los stream para que no gaste recursos cuando no se estan usando
  // await _todoFetcher.drain();
  // _todoFetcher.close();
  // }
}

// final bloc = PromoBloc();

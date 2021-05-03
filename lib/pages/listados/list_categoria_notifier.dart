import 'package:fastshop/models/categoria.dart';
import 'package:flutter/cupertino.dart';

class ListCategoriaNotifier with ChangeNotifier {
  List<Categoria> _selected = [];

  List<Categoria> get listCategoria => _selected;

  clearAll() {
    _selected.clear();
  }

  void addToList(Categoria cate) {
    _selected.add(cate);
    notifyListeners();
  }

  void removeToList(Categoria cate) {
    _selected.remove(cate);
    notifyListeners();
  }

  set listCategoria(List<Categoria> listCategoria) {
    _selected = listCategoria;
    notifyListeners();
  }
}

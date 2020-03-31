import 'dart:convert';

import 'package:fastshop_mobile/models/models.dart';

List<ListadoXCategoria> listXCatFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ListadoXCategoria>.from(jsonData.map((x) => ListadoXCategoria.fromJson(x)));
}
//Este metodo me permite un listado en flutter convertirlo en JSON
String listXCatToJson(List<ListadoXCategoria> data) {
  //Agregar el .toList() me soluciono el problema de meter una lista en JSON sin los slashes molestos
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()).toList());
  return json.encode(dyn);
}

class ListadoXCategoria {
  String idCategoria;
  String idListado;

  ListadoXCategoria({
    this.idCategoria,
    this.idListado,
  });

  List<ListadoXCategoria> createListXCate(idListado, List<Categoria> list){
    List<ListadoXCategoria> listado = [];
    ListadoXCategoria lxc;
    for(var i=0; i<list.length; i++ ){
      lxc = new ListadoXCategoria(idCategoria: list[i].idCategoria, idListado: idListado);
      listado.add(lxc);
    }
    return listado;

  }

  factory ListadoXCategoria.fromJson(Map<String, dynamic> json) => new ListadoXCategoria(
    idCategoria: json["idCategoria"],
    idListado: json["idListado"],

  );

  Map<String, dynamic> toJson() => {
    "idCategoria": idCategoria,
    "idListado": idListado,
  };

}

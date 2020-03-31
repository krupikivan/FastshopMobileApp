import 'dart:convert';

List<ListCategory> listCategoriesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ListCategory>.from(jsonData.map((x) => ListCategory.fromJson(x)));
}

String listCategoriesToJson(List<ListCategory> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class ListCategory {
  String idCategoria;
  String descripcion;

  ListCategory({
    this.idCategoria,
    this.descripcion,
  });

  factory ListCategory.fromJson(Map<String, dynamic> json) => new ListCategory(
    idCategoria: json["idCategoria"],
    descripcion: json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "idCategoria": idCategoria,
    "descripcion": descripcion,
  };
}

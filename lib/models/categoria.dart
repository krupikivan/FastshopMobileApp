import 'dart:convert';

List<Categoria> categoriaFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Categoria>.from(jsonData.map((x) => Categoria.fromJson(x)));
}

String categoriaToJson(List<Categoria> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

listxCate(List<Categoria> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJsonMin()));
  return dyn;
  // return json.encode(dyn);
}

class Categoria {
  int idCategoria;
  String descripcion;
  int superior;

  Categoria({
    this.idCategoria,
    this.descripcion,
    this.superior,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => new Categoria(
        idCategoria: json["idCategoria"],
        descripcion: json["descripcion"],
        superior: json["superior"],
      );

  Map<String, dynamic> toJsonMin() => {
        "idCategoria": idCategoria,
      };

  Map<String, dynamic> toJson() => {
        "idCategoria": idCategoria,
        "descripcion": descripcion,
        "superior": superior,
      };
}

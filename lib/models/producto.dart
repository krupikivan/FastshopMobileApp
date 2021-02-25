import 'dart:convert';
import 'dart:ui';

List<Producto> productoFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Producto>.from(jsonData.map((x) => Producto.fromJson(x)));
}

String productoToJson(List<Producto> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Producto extends Object {
  final int idProducto;
  final String descripcion;
  final String categoria;
  final String marca;
  final double precio;

  Producto({
    this.idProducto,
    this.descripcion,
    this.categoria,
    this.marca,
    this.precio,
  });

  Producto.fromJson(Map<String, dynamic> json)
      : idProducto = json["idProducto"] as int,
        descripcion = json["descripcion"],
        categoria = json["categoria"],
        marca = json["marca"],
        precio = double.parse(json["precio"].toString());

  // Producto.clear()
  //  : idProducto = null,
  //   descripcion = null,
  //   categoria = null,
  //   marca = null,
  //   precio = null;

  Map<String, dynamic> toJson() => {
        "idProducto": idProducto,
        "descripcion": descripcion,
        "categoria": categoria,
        "marca": marca,
        "precio": precio,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => idProducto;
}

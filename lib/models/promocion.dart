// To parse this JSON data, do
//
//     final promocion = promocionFromJson(jsonString);

import 'dart:convert';

List<Promocion> promocionFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Promocion>.from(jsonData.map((x) => Promocion.fromJson(x)));
}

String promocionToJson(List<Promocion> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Promocion {
  final int idPromocion;
  final int idProducto;
  final double formula;
  final int productoAplicado;
  final int cantidadProductos;
  final int prioridad;
  final int idCategoria;
  final String fechaFin;
  final String fechaInicio;
  final String producto;
  final String categoria;
  final String promocion;

  Promocion({
    this.idPromocion,
    this.formula,
    this.productoAplicado,
    this.idProducto,
    this.cantidadProductos,
    this.prioridad,
    this.idCategoria,
    this.fechaFin,
    this.fechaInicio,
    this.producto,
    this.promocion,
    this.categoria,
  });

  String get showText {
    if (producto.isEmpty) {
      return categoria;
    }
    return producto;
  }

  bool get isProducto {
    if (producto.isEmpty) {
      return false;
    }
    return true;
  }

  factory Promocion.fromJson(Map<String, dynamic> json) => new Promocion(
        idPromocion: json["idPromocion"],
        idProducto: json["IdProducto"],
        prioridad: json["Prioridad"],
        cantidadProductos: json["cantidadProductos"],
        formula: json["formula"],
        productoAplicado: json["productoAplicado"],
        idCategoria: json["IdCategoria"],
        fechaFin: json["fechaFin"],
        fechaInicio: json["fechaInicio"],
        producto: json["producto"],
        categoria: json["categoria"],
        promocion: json["promocion"],
      );

  Map<String, dynamic> toJson() => {
        "idPromocion": idPromocion,
        "idProducto": idProducto,
        "formula": formula,
        "productoAplicado": productoAplicado,
        "cantidadProductos": cantidadProductos,
        "idCategoria": idCategoria,
        "prioridad": prioridad,
        "fechaFin": fechaFin,
        "fechaInicio": fechaInicio,
        "producto": producto,
        "categoria": categoria,
        "promocion": promocion,
      };
}

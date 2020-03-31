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
  final String idPromocion;
  final String fechaFin;
  final String fechaInicio;
  final String producto;
  final String promocion;

  Promocion({
    this.idPromocion,
    this.fechaFin,
    this.fechaInicio,
    this.producto,
    this.promocion,
  });

  factory Promocion.fromJson(Map<String, dynamic> json) => new Promocion(
    idPromocion: json["idPromocion"],
    fechaFin: json["fechaFin"],
    fechaInicio: json["fechaInicio"],
    producto: json["producto"],
    promocion: json["promocion"],
  );

  Map<String, dynamic> toJson() => {
    "idPromocion": idPromocion,
    "fechaFin": fechaFin,
    "fechaInicio": fechaInicio,
    "producto": producto,
    "promocion": promocion,
  };
}

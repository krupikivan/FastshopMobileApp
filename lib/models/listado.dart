// To parse this JSON data, do
//
//     final promocion = promocionFromJson(jsonString);

import 'dart:convert';

List<Listado> listadoFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Listado>.from(jsonData.map((x) => Listado.fromJson(x)));
}

String listadoToJson(List<Listado> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Listado {
  String idListado;
  String nombre;
  String producto;
  String cantidad;
  String cliente;

  Listado({
    this.idListado,
    this.nombre,
    this.producto,
    this.cantidad,
    this.cliente,
  });

  factory Listado.fromJson(Map<String, dynamic> json) => new Listado(
    idListado: json["idListado"],
    nombre: json["nombre"],
    producto: json["producto"],
    cantidad: json["cantidad"],
    cliente: json["cliente"],
  );

  Map<String, dynamic> toJson() => {
    "idListado": idListado,
    "nombre": nombre,
    "producto": producto,
    "cantidad": cantidad,
    "cliente": cliente,
  };
}

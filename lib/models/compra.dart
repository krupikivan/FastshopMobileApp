// To parse this JSON data, do
//
//     final promocion = promocionFromJson(jsonString);
import 'package:intl/intl.dart';
import 'dart:convert';

List<Compra> listadoFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Compra>.from(jsonData.map((x) => Compra.fromJson(x)));
}

String listadoToJson(List<Compra> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Compra {
  int idCompra;
  DateTime fechaCompra;
  int idCliente;
  int cantidad;
  int total;

  Compra({
    this.idCompra,
    this.fechaCompra,
    this.idCliente,
    this.cantidad,
    this.total,
  });

  String get fecha => DateFormat('dd/MM/yyyy').format(fechaCompra);

  factory Compra.fromJson(Map<String, dynamic> json) => new Compra(
        idCompra: json["IdCompra"],
        fechaCompra: DateTime.parse(json["fechaCompra"]),
        idCliente: json["idCliente"],
        cantidad: json["cantidad"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "IdCompra": idCompra,
        "fechaCompra": fechaCompra,
        "idCliente": idCliente,
        "cantidad": cantidad,
        "total": total,
      };
}

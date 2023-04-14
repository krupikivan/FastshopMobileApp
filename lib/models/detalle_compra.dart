// To parse this JSON data, do
//
//     final promocion = promocionFromJson(jsonString);
import 'dart:convert';

List<DetalleCompra> detalleFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<DetalleCompra>.from(
      jsonData.map((x) => DetalleCompra.fromJson(x)));
}

String detalleToJson(List<DetalleCompra> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class DetalleCompra {
  int idCompra;
  String descripcion;
  double precio;
  int cantidad;
  double descuento;
  double totalCompra;

  DetalleCompra({
    this.idCompra,
    this.descripcion,
    this.precio,
    this.cantidad,
    this.descuento,
    this.totalCompra,
  });

  factory DetalleCompra.fromJson(Map<String, dynamic> json) =>
      new DetalleCompra(
        idCompra: json["IdCompra"] ?? 0,
        descripcion: json["descripcion"],
        precio: double.parse(json["precio"].toString()),
        cantidad: json["cantidad"],
        descuento: double.parse(json["descuento"].toString()),
        totalCompra: double.parse(json["totalCompra"].toString()),
      );

  double get total {
    return (precio * cantidad) - descuento;
  }

  double get monto {
    return precio * cantidad;
  }

  bool get hasPromo {
    return descuento > 0;
  }

  toJson() {
    return {
      "IdCompra": idCompra,
      "descripcion": descripcion,
      "precio": precio,
      "cantidad": cantidad,
      "descuento": descuento,
      "totalCompra": totalCompra,
    };
  }
}

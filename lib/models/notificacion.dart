import 'dart:convert';

List<Notificacion> notificacionFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Notificacion>.from(
      jsonData.map((x) => Notificacion.fromJson(x)));
}

class Notificacion {
  String id;
  String cuerpo;
  String titulo;

  Notificacion({this.id, this.cuerpo, this.titulo});

  Notificacion.fromJson(Map<String, dynamic> json)
      : cuerpo = json["cuerpo"],
        id = json["id"],
        titulo = json["titulo"];
}

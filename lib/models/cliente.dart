
class Cliente {

   String nombre;
   String apellido;
   String email;
   String token;
   int idCliente;

  Cliente({this.nombre, this.token, this.idCliente, this.apellido, this.email});

  /*Cliente.empty(){
    this.username = "";
    this.token = "";
    this.idCliente = "";
  }*/

  int getId(){
    return idCliente;
  }

  Cliente.fromJson(Map<String, dynamic> json)
    : nombre = json["nombre"],
      email = json["email"],
      apellido = json["apellido"],
      idCliente = json["idCliente"] as int,
      token = json["token"];

  Map<String, dynamic> toJson() =>
      {
        'nombre': nombre,
        'email': email,
        'apellido': apellido,
        'idCliente': idCliente,
        'token': token,
      };
}

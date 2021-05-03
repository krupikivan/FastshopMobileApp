import 'package:shared_preferences/shared_preferences.dart';
import 'package:fastshop/models/cliente.dart';

saveCurrentLogin(Map responseJson) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //var username;

  if ((responseJson != null && !responseJson.isEmpty)) {
    prefs.setString('email', Cliente.fromJson(responseJson).email);
    prefs.setString('nombre', Cliente.fromJson(responseJson).nombre);
    prefs.setString('apellido', Cliente.fromJson(responseJson).apellido);
    prefs.setString('token', Cliente.fromJson(responseJson).token);
    prefs.setInt('idCliente', Cliente.fromJson(responseJson).idCliente);
  }

  //var token = (responseJson != null && !responseJson.isEmpty) ? Cliente.fromJson(responseJson).token : "";
  //int idCliente = (responseJson != null && !responseJson.isEmpty) ? Cliente.fromJson(responseJson).idCliente : 0;

  //await prefs.setString('LastUser', (username != null && username.length > 0) ? username : "");
  //await prefs.setString('LastToken', (token != null && token.length > 0) ? token : "");
  //await preferences.setInt('LastUserId', (idCliente != null && idCliente > 0) ? idCliente : 0);
}

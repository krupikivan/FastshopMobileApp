

import 'package:shared_preferences/shared_preferences.dart';

getIdCliente() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String getIdCliente = await preferences.getString("idCliente");
  return getIdCliente;
}
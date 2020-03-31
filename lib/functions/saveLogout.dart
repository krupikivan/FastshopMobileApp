
import 'package:shared_preferences/shared_preferences.dart';

saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString('nombre', "");
  await preferences.setString('apellido', "");
  await preferences.setString('email', "");
  await preferences.setString('token', "");
  await preferences.setInt('idCliente', 0);
}
import 'package:shared_preferences/shared_preferences.dart';

getTokenJwt(SharedPreferences preferences) async {
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  
 String jwt = preferences.getString("token");
  return jwt;
}
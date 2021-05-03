// import 'dart:convert';
// import 'package:fastshop/connection.dart';
// import 'package:fastshop/functions/saveCurrentLogin.dart';
// import 'package:fastshop/models/cliente.dart';
// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;

// class UserRepository {

//   final String _url = 'http://' + con.getUrl() + '/login.php';
//   final String _url2 = 'http://' + con.getUrl() + '/signup.php';
//   var headers = {"accept" : "application/json"};

//   Future<Cliente> authenticate({
//     @required String email,
//     @required String password,
//   }) async {

//     //Creamos el body para mandar por POST
//     Map<String, String> body = {
//       'email': email,
//       'password': password,
//     };

//     await Future.delayed(Duration(seconds: 1));

//     final response = await http.post(_url, body: jsonEncode(body), headers: headers);

//       if (response.statusCode == 200) {
//         Map userMap = jsonDecode(response.body);
//         //var client = new Cliente.fromJson(userMap);
//         saveCurrentLogin(userMap);
//         return Cliente.fromJson(userMap);
//       }else{
//         final responseJson = json.decode(response.body);
//         saveCurrentLogin(responseJson);
//         //Con esta exepcion no permitimos que se inicie sesion permitiendonos mostrar el mensaje de Usuario o contraseña invalido
//         throw new Exception("No se pudo loguear!");
//       }
//     }

//   Future<bool> signup({
//     @required String nombre,
//     @required String apellido,
//     @required String email,
//     @required String password,
//   }) async {

//     //Creamos el body para mandar por POST
//     Map<String, String> body = {
//       'nombre': nombre,
//       'apellido': apellido,
//       'email': email,
//       'password': password,
//     };

//     await Future.delayed(Duration(seconds: 1));
//     final response = await http.post(_url2, body: jsonEncode(body), headers: headers);
//     if (response.statusCode == 400) {
//       return false;
//     }
//     return true;
//   }

//   Future<void> deleteToken() async {
//     /// delete from keystore/keychain
//     //_storage.delete(key: 'jwt');
//     await Future.delayed(Duration(seconds: 1));
//     return;
//   }

//   Future<void> persistToken(String token) async {
//     /// write to keystore/keychain
//     //_storage.write(key: 'jwt', value: client.token);
//     await Future.delayed(Duration(seconds: 1));
//     return;
//   }

//   Future<bool> hasToken() async {
//     /// read from keystore/keychain
//     await Future.delayed(Duration(seconds: 1));
//     return false;
//   }
// }

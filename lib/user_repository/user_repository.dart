import 'dart:convert';
import 'package:fastshop_mobile/connection.dart';
import 'package:fastshop_mobile/functions/getUserData.dart';
import 'package:fastshop_mobile/functions/saveCurrentLogin.dart';
import 'package:fastshop_mobile/functions/savelogout.dart';
import 'package:fastshop_mobile/models/cliente.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UserRepository with ChangeNotifier {
  final String _url = 'https://' + con.getUrl() + '/login.php';
  final String _url2 = 'https://' + con.getUrl() + '/signup.php';
  final String _url3 = 'https://' + con.getUrl() + '/validate_token.php';
  var headers = {"accept": "application/json"};

  Cliente _userData = Cliente();
  String _token;
  String get token => _token;
  Cliente get userData => _userData;

  set userData(Cliente userData) {
    _userData = userData;
    notifyListeners();
  }

  set token(String token) {
    _token = token;
    notifyListeners();
  }

  Future<Cliente> authenticate({
    @required String email,
    @required String password,
  }) async {
    //Creamos el body para mandar por POST
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    await Future.delayed(Duration(seconds: 1));
    var response;
    try {
      response =
          await http.post(_url, body: jsonEncode(body), headers: headers);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      //var client = new Cliente.fromJson(userMap);
      _userData = Cliente.fromJson(userMap);
      notifyListeners();
      saveCurrentLogin(userMap);
      return Cliente.fromJson(userMap);
    } else {
      final responseJson = json.decode(response.body);
      saveCurrentLogin(responseJson);
      //Con esta exepcion no permitimos que se inicie sesion permitiendonos mostrar el mensaje de Usuario o contraseña invalido
      throw new Exception("No se pudo loguear!");
    }
  }

  Future<bool> signup({
    @required String nombre,
    @required String apellido,
    @required String email,
    @required String password,
  }) async {
    //Creamos el body para mandar por POST
    Map<String, String> body = {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'password': password,
    };
    print(jsonEncode(body));
    await Future.delayed(Duration(seconds: 1));
    final response =
        await http.post(_url2, body: jsonEncode(body), headers: headers);
    print(jsonEncode(body));
    print(response.body);
    if (response.statusCode == 400) {
      return false;
    }
    return true;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    //_storage.delete(key: 'jwt');
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<Cliente> persistToken({@required String token}) async {
    Map<String, String> body = {
      'jwt': token,
    };
    await Future.delayed(Duration(seconds: 1));
    final response =
        await http.post(_url3, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      _userData = Cliente.fromJson(userMap);
      notifyListeners();
      return _userData;
    } else {
      throw new Exception("No se pudo loguear!");
    }
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}

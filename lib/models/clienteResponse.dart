import 'package:fastshop_mobile/models/models.dart';

class ClienteResponse {
  final List<Cliente> results;
  final String error;

  ClienteResponse(this.results, this.error);

  ClienteResponse.fromJson(Map<String, dynamic> json)
      : results =
  (json["results"] as List).map((i) => new Cliente.fromJson(i)).toList(),
        error = "";

  ClienteResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}
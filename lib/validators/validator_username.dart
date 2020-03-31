import 'dart:async';

const String _kNombreRule = r"^[a-zA-Z0-9]";

class NombreValidator {
  final StreamTransformer<String,String> validateNombre = StreamTransformer<String,String>.fromHandlers(handleData: (nombre, sink){
    final RegExp nombreExp = new RegExp(_kNombreRule);

    if (!nombreExp.hasMatch(nombre) || nombre.isEmpty || nombre.length < 4){
      sink.addError('Ingrese un nombre valido');
    } else {
      sink.add(nombre);
    }
  });
}

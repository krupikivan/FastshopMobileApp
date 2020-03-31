import 'dart:async';
import 'package:fastshop_mobile/bloc_helpers/bloc_provider.dart';
import 'package:fastshop_mobile/validators/validators_all.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationFormBloc extends Object with EmailValidator, PasswordValidator, NombreValidator implements BlocBase {

  final BehaviorSubject<String> _nombreController = BehaviorSubject<String>();
  final BehaviorSubject<String> _apellidoController = BehaviorSubject<String>();
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordConfirmController = BehaviorSubject<String>();

  //
  //  Inputs
  //
  Function(String) get onNombreChanged => _nombreController.sink.add;
  Function(String) get onApellidoChanged => _apellidoController.sink.add;
  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;
  Function(String) get onRetypePasswordChanged => _passwordConfirmController.sink.add;

  //
  // Validators
  //
  Stream<String> get nombre => _nombreController.stream.transform(validateNombre);
  Stream<String> get apellido => _apellidoController.stream.transform(validateNombre);
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<String> get confirmPassword => _passwordConfirmController.stream.transform(validatePassword)
    .doOnData((String c){
      // If the password is accepted (after validation of the rules)
      // we need to ensure both password and retyped password match
      if (0 != _passwordController.value.compareTo(c)){
        // If they do not match, add an error
        _passwordConfirmController.addError("No Match");
      }
    });

  //
  // Registration button
  Stream<bool> get registerValid => Observable.combineLatest4(
                                      nombre,
                                      // apellido,
                                      email,
                                      password, 
                                      confirmPassword,
                                      (n, e, p, c) => true
                                    );

  @override
  void dispose() {
    _nombreController?.close();
    _apellidoController?.close();
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmController?.close();
  }
}
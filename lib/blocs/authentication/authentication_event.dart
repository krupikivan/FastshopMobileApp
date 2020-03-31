import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:fastshop_mobile/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends Equatable with BlocEvent {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationEventLogin({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

}
class AuthenticationEventCheckingToken extends AuthenticationEvent {
  final String token;

  AuthenticationEventCheckingToken({
    @required this.token,
  }) : super([token]);

}

class AuthenticationEventLogout extends AuthenticationEvent {}

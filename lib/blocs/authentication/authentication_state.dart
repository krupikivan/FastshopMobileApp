import 'package:fastshop/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class AuthenticationState extends BlocState {
  AuthenticationState({
    @required this.isAuthenticated,
    this.isAuthenticating: false,
    this.hasFailed: false,
  });

  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;

  factory AuthenticationState.notAuthenticated() {
    return AuthenticationState(
      isAuthenticated: false,
    );
  }
  // factory AuthenticationState.checkingToken() {
  //   return AuthenticationState(
  //     isAuthenticated: true,
  //   );
  // }

  factory AuthenticationState.authenticated() {
    return AuthenticationState(
      isAuthenticated: true,
    );
  }

  factory AuthenticationState.authenticating() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: true,
    );
  }

  factory AuthenticationState.failure() {
    return AuthenticationState(
      isAuthenticated: false,
      hasFailed: true,
    );
  }
}

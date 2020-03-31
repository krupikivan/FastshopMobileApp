import 'dart:async';
import 'package:fastshop_mobile/functions/saveLogout.dart';
import 'package:fastshop_mobile/models/cliente.dart';
import 'package:meta/meta.dart';
import 'package:fastshop_mobile/user_repository/user_repository.dart';
import 'package:fastshop_mobile/bloc_helpers/bloc_event_state.dart';
import 'package:fastshop_mobile/blocs/authentication/authentication_event.dart';
import 'package:fastshop_mobile/blocs/authentication/authentication_state.dart';

class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({
    @required this.userRepository,
  })  : assert(userRepository.token != null),
        super(
          initialState: AuthenticationState.notAuthenticated(),
        );

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {

    if (event is AuthenticationEventLogin) {
      // Inform that we are proceeding with the authentication
      yield AuthenticationState.authenticating();

      // Simulate a call to the authentication server
      try {
        await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        yield AuthenticationState.authenticated();
      } catch (error) {
        yield AuthenticationState.failure();
      }
    }

    if (event is AuthenticationEventCheckingToken) {
      // Inform that we are proceeding with the authentication
      yield AuthenticationState.authenticating();

      // Simulate a call to the authentication server
      try {
        await userRepository.persistToken(
          token: event.token,
        );
        print(userRepository.userData.email);
        yield AuthenticationState.authenticated();
      } catch (error) {
        yield AuthenticationState.failure();
      }
    }

    if (event is AuthenticationEventLogout) {
      saveLogout();

      yield AuthenticationState.notAuthenticated();
    }
  }
}

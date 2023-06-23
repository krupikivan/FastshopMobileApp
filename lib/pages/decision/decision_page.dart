import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop/blocs/authentication/authentication_event.dart';
import 'package:fastshop/blocs/authentication/authentication_state.dart';
import 'package:fastshop/pages/authentication/authentication_page.dart';
import 'package:fastshop/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fastshop/user_repository/user_repository.dart';

import '../../preferences.dart';

class DecisionPage extends StatefulWidget {
  //Para el username
  final UserRepository userRepository;

  DecisionPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  DecisionPageState createState() {
    return new DecisionPageState();
  }
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;
  //UserRepository get _userRepository => widget.userRepository;

  @override
  Widget build(BuildContext context) {
    final _prefs = Preferences();
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    if (bloc.userRepository.token != "") {
      bloc.emitEvent(
          AuthenticationEventCheckingToken(token: bloc.userRepository.token));
    }
    return BlocEventStateBuilder<AuthenticationState>(
        bloc: bloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state != oldAuthenticationState) {
            oldAuthenticationState = state;
            if (state.isAuthenticated) {
              _redirectToPage(
                context,
                HomePage(
                  index: _prefs.index,
                ),
              );
              // )
              // );
            } else if (state.isAuthenticating || state.hasFailed) {
              //do nothing
            } else {
              _redirectToPage(context, AuthenticationPage());
            }
          }

          // This page does not need to display anything since it will
          // always remain behind any active page (and thus 'hidden').
          return Container();
        });
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);

      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}

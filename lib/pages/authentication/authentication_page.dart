import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop/blocs/authentication/authentication_event.dart';
import 'package:fastshop/blocs/authentication/authentication_state.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/user_repository/user_repository.dart';
import 'package:fastshop/widgets/pending_action.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPage extends StatelessWidget {
  final UserRepository userRepository;

  const AuthenticationPage({Key key, this.userRepository}) : super(key: key);
  Future<bool> _onWillPopScope() async {
    return false;
  }

  build(context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Iniciar Sesion'),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: AuthenticationPageLogin(),
        ),
      ),
    );
  }
}

class AuthenticationPageLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AuthenticationPageLoginState();
  }
}

class AuthenticationPageLoginState extends State<AuthenticationPageLogin> {
  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _saveCurrentRoute("/loginScreen");
    setState(() {
      _emailController.text = "";
      _passwordController.text = "";
    });
  }

  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      child: BlocEventStateBuilder<AuthenticationState>(
        bloc: bloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state.isAuthenticating) {
            return PendingAction();
          }

          if (state.isAuthenticated) {
            return Container();
          }

          List<Widget> children = <Widget>[];

          // Button to fake the authentication (success)
          children.add(
            ListTile(
              title: Column(
                children: <Widget>[
                  Image.asset('assets/logo.png', scale: 1.5),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          );

          children.add(
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: _emailController,
              ),
            ),
          );

          children.add(
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                controller: _passwordController,
                obscureText: true,
              ),
            ),
          );

          children.add(
            ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: () {
                    bloc.emitEvent(AuthenticationEventLogin(
                        email: _emailController.text,
                        password: _passwordController.text));
                  },
                  padding: EdgeInsets.all(10),
                  color: primaryColor,
                  child: Text('Iniciar Sesion',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          );

          children.add(
            ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Text('Registrate con tu mail',
                      style: TextStyle(color: primaryColor)),
                ),
              ),
            ),
          );

          // Display a text if the authentication failed
          if (state.hasFailed) {
            children.add(
              Text('Usuario o Contraseña incorrecto!',
                  style: TextStyle(fontSize: 15.0, color: Colors.red)),
            );
          }

          return Column(
            children: children,
          );
        },
      ),
    );
  }
}

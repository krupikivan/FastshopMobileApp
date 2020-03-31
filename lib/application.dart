import 'package:fastshop_mobile/bloc_helpers/bloc_provider.dart';
import 'package:fastshop_mobile/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop_mobile/blocs/cart/cart_bloc.dart';
import 'package:fastshop_mobile/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop_mobile/design/colors.dart';
import 'package:fastshop_mobile/pages/authentication/authentication_page.dart';
import 'package:fastshop_mobile/pages/listados/list_categoria_notifier.dart';
import 'package:fastshop_mobile/pages/shopping/cart_page.dart';
import 'package:fastshop_mobile/pages/decision/decision_page.dart';
import 'package:fastshop_mobile/pages/authentication/initialization_page.dart';
import 'package:fastshop_mobile/pages/registration/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:fastshop_mobile/user_repository/user_repository.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final String token;

  Application({Key key, this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    userRepository.token = token;
    return MultiProvider(
      providers: [
      ChangeNotifierProvider<ListCategoriaNotifier>(create: (context) => ListCategoriaNotifier()),
      ChangeNotifierProvider(create: (_) => userRepository),
      ],
          child: BlocProvider<AuthenticationBloc>(
          bloc: AuthenticationBloc(userRepository: userRepository),
          child: BlocProvider<ShoppingBloc>(
            bloc: ShoppingBloc(),
            child: BlocProvider<CartBloc>(
              bloc: CartBloc(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                        title: 'FastShop',
                        theme: ThemeData(
                          primarySwatch: primaryColor,
                        ),
                        routes: {
                          '/decision': (BuildContext context) => DecisionPage(
                                userRepository: userRepository,
                              ),
                          '/register': (BuildContext context) =>
                              RegistrationPage(),
                          '/loginScreen': (BuildContext context) =>
                              AuthenticationPage(userRepository: userRepository),
                          '/shoppingBasket': (BuildContext context) =>
                              BlocCartPage(),
                        },
                        home: InitializationPage()),
              ),
            ),
        ),
    );
  }
}

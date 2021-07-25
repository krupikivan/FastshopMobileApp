import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/blocs/home/notification_bloc.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/pages/authentication/authentication_page.dart';
import 'package:fastshop/pages/listados/list_categoria_notifier.dart';
import 'package:fastshop/pages/notificacion_page.dart';
import 'package:fastshop/pages/shopping/cart_page.dart';
import 'package:fastshop/pages/decision/decision_page.dart';
import 'package:fastshop/pages/authentication/initialization_page.dart';
import 'package:fastshop/pages/registration/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:fastshop/user_repository/user_repository.dart';
import 'package:provider/provider.dart';

import 'blocs/home/promo_bloc.dart';

class Application extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final String token;

  Application({Key key, this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    userRepository.token = token;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListCategoriaNotifier>(
            create: (context) => ListCategoriaNotifier()),
        ChangeNotifierProvider<PromoBloc>(
            create: (context) => PromoBloc.init()),
        ChangeNotifierProvider<NotificationBloc>(
            create: (context) => NotificationBloc.init()),
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
                  '/register': (BuildContext context) => RegistrationPage(),
                  '/loginScreen': (BuildContext context) =>
                      AuthenticationPage(userRepository: userRepository),
                  '/shoppingBasket': (BuildContext context) => BlocCartPage(),
                  '/notification': (BuildContext context) => NotificationPage(),
                },
                home: InitializationPage()),
          ),
        ),
      ),
    );
  }
}

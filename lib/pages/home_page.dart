import 'dart:async';
import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/cart/cart_bloc.dart';
import 'package:fastshop/blocs/home/notification_bloc.dart';
import 'package:fastshop/blocs/home/promo_bloc.dart';
import 'package:fastshop/models/promocion.dart';
import 'package:fastshop/pages/active_offer.dart';
import 'package:fastshop/pages/category_page.dart';
import 'package:fastshop/pages/listados/shop_list_page.dart';
import 'package:fastshop/pages/shopping/cart_page.dart';
import 'package:fastshop/user_repository/user_repository.dart';
import 'package:fastshop/widgets/log_out_button.dart';
import 'package:fastshop/widgets/notification_icon.dart';
import 'package:fastshop/widgets/shopping_basket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../preferences.dart';
import 'compra/compra_page.dart';

class HomePage extends StatefulWidget {
  final int index;

  const HomePage({Key key, @required this.index}) : super(key: key);
  @override
  HomePageSample createState() => new HomePageSample();
}

class HomePageSample extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var user;
  final _prefs = Preferences();

  Timer timer;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      Provider.of<PromoBloc>(context, listen: false).getPromos();
      Provider.of<NotificationBloc>(context, listen: false).getNotif();
    });
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    Future.delayed(Duration(seconds: 2));
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Nueva promocion!!!"),
          content: Text(payload),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      },
    );
  }

  Future _showNotification(List<Promocion> data) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    if (data.length > _prefs.promoCant) {
      print(
          'Cantidad guardada: ${_prefs.promoCant} ::: Cantidad traida: ${data.length} ::: Mostrando promocion de ${data.last.producto}');
      _prefs.promoCant = data.length;
      await flutterLocalNotificationsPlugin.show(
        0,
        'Nueva Promocion',
        '${data.last.promocion} - ${data.last.producto}',
        platformChannelSpecifics,
        payload:
            'Tenemos una nueva promocion del producto: ${data.last.producto}',
      );
    } else if (data.length < _prefs.promoCant) {
      _prefs.promoCant = data.length;
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future<bool> _onWillPopScope() async {
    return false;
  }

  List<Widget> _tabItems() => [
        Tab(text: "Promociones", icon: new Icon(Icons.pages)),
        Tab(text: "Categorias", icon: new Icon(Icons.shop)),
        Tab(text: "Carrito", icon: new Icon(Icons.shopping_cart)),
        Tab(text: "Listado", icon: new Icon(Icons.list)),
        Tab(text: "Mis Compras", icon: new Icon(Icons.shop)),
      ];

  TabBar _tabBarLabel() => TabBar(
        tabs: _tabItems(),
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        onTap: (index) {
          var content = "";
          switch (index) {
            case 0:
              content = "Promociones";
              break;
            case 1:
              content = "Categorias";
              break;
            case 2:
              content = "Carrito";
              break;
            case 3:
              content = "Listado";
              break;
            case 4:
              content = "Mis Compras";
              break;
            default:
              content = "Other";
              break;
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserRepository>(context);
    final _cartBloc = BlocProvider.of<CartBloc>(context);
    print('Usuario logueado: ${userData.userData.idCliente}');
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: DefaultTabController(
        length: _tabItems().length,
        initialIndex: widget.index,
        child: Consumer<PromoBloc>(builder: (context, snapshot, _) {
          if (snapshot.promociones.isNotEmpty) {
            _cartBloc.addPromos.add(snapshot.promociones);
            _showNotification(snapshot.promociones);
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(userData.userData.nombre),
                leading: LogOutButton(),
                actions: <Widget>[
                  InkWell(
                    child: NotificationIcon(),
                    onTap: () {
                      Navigator.of(context).pushNamed('/notification');
                    },
                  ),
                  InkWell(
                    child: ShoppingBasket(),
                    onTap: () {
                      // Navigator.of(context).pushNamed('/shoppingBasket');
                    },
                  ),
                ],
                bottom: _tabBarLabel(),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: TabBarView(children: <Widget>[
                        ActiveOfferPage(),
                        CategoryPage(),
                        BlocCartPage(),
                        ShopListPage(),
                        CompraPage(),
                      ]),
                    ),
                  )
                ],
              ));
        }),
      ),
    );
  }
}

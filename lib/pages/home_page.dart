import 'dart:async';
import 'package:fastshop_mobile/functions/getUsername.dart';
import 'package:fastshop_mobile/pages/active_offer.dart';
import 'package:fastshop_mobile/pages/category_page.dart';
import 'package:fastshop_mobile/pages/listados/shop_list_page.dart';
import 'package:fastshop_mobile/pages/shopping/cart_page.dart';
import 'package:fastshop_mobile/pages/test_page.dart';
import 'package:fastshop_mobile/repos/user_repository.dart';
import 'package:fastshop_mobile/user_repository/user_repository.dart';
import 'package:fastshop_mobile/widgets/log_out_button.dart';
import 'package:fastshop_mobile/widgets/shopping_basket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int index;

  const HomePage({Key key, @required this.index}) : super(key: key);
  @override
  HomePageSample createState() => new HomePageSample();
}

class HomePageSample extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var user;

  // HomePageSample(this.user);
  // Future<void> _getUsername() async {
  //   user = await getUsername();
  // }

  @override
  void initState() {
    super.initState();
    // if(index == null){
    //   index = 0;
    // }
    // _getUsername();
    Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPopScope() async {
    return false;
  }

  List<Widget> _tabItems() => [
        Tab(text: "Promociones", icon: new Icon(Icons.pages)),
        Tab(text: "Categorias", icon: new Icon(Icons.shop)),
        Tab(text: "Carrito", icon: new Icon(Icons.shopping_cart)),
        Tab(text: "Listado", icon: new Icon(Icons.list)),
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
            default:
              content = "Other";
              break;
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserRepository>(context);
    print('Usuario logueado: ${userData.userData.idCliente}');
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: DefaultTabController(
        length: 4,
        initialIndex: widget.index,
        child: Scaffold(
            appBar: AppBar(
              title: Text(userData.userData.nombre),
              leading: LogOutButton(),
              actions: <Widget>[
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ShoppingBasket(),
                    ],
                  ),
                  onTap: () {Navigator.of(context).pushNamed('/shoppingBasket');},
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
                      ShopListPage()
                    ]),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

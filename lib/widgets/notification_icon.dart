import 'package:fastshop/blocs/home/notification_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../preferences.dart';

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 48.0,
      child: Stack(
        children: <Widget>[
          Center(
            child: const Icon(Icons.notification_important),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(5.0, -30.0),
                child: Consumer<NotificationBloc>(
                    //stream: bloc.shoppingBasketSize,
                    builder: (BuildContext context, snapshot, _) {
                  if (Preferences().notif.length <
                      snapshot.notifications.length) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // child: Center(
                      //   child: Text(
                      //     '${snapshot.data}',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 10.0,
                      //     ),
                      //   ),
                      // ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
              )),
        ],
      ),
    );
  }
}

import 'package:fastshop/blocs/home/notification_bloc.dart';
import 'package:fastshop/models/notificacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../preferences.dart';

class NotificationIcon extends StatefulWidget {
  @override
  _NotificationIconState createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  final _prefs = Preferences();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (_) {
      return Navigator.of(context).pushNamed('/notification');
    });
    super.initState();
  }

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
                  if (_prefs.notifCant < snapshot.notifications.length) {
                    _showNotification(snapshot.notifications);
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

  Future _showNotification(List<Notificacion> data) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    if (data.length > _prefs.notifCant) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Nueva Notificacion',
        data.first.titulo,
        platformChannelSpecifics,
        payload: data.first.cuerpo,
      );
    }
    _prefs.notifCant = data.length;
  }
}

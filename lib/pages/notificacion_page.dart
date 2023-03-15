import 'package:fastshop/blocs/home/notification_bloc.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/models/notificacion.dart';
import 'package:fastshop/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notificaciones"),
          backgroundColor: primaryColor,
        ),
        body: Consumer<NotificationBloc>(
          builder: (context, snapshot, _) {
            Future.delayed(Duration(seconds: 3)).then((value) =>
                Provider.of<NotificationBloc>(context, listen: false)
                    .saveData());
            //Aca largamos la lista a la pantalla
            return snapshot.notifications.length == 0
                ? Center(
                    child: Text('Sin Notificaciones',
                        style: Theme.of(context).textTheme.headline4))
                : buildList(snapshot.notifications);
          },
        ));
  }

  Widget buildList(List<Notificacion> snapshot) {
    return ListView.builder(
        itemCount: snapshot.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(snapshot[index].titulo),
              leading: Icon(
                Icons.notifications_outlined,
                color: Preferences().notif.contains(snapshot[index].id)
                    ? Colors.grey
                    : Colors.yellow[700],
              ),
              subtitle: Text(snapshot[index].cuerpo),
            ));
  }
}

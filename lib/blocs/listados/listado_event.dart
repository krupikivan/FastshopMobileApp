import 'package:fastshop_mobile/bloc_helpers/bloc_event_state.dart';
import 'package:fastshop_mobile/models/cliente.dart';
import 'package:meta/meta.dart';


class ListDelete extends BlocEvent {

  final ListadoEventType event;
  final String idList;


  ListDelete({
    @required this.event,
    @required this.idList,
  });
}

class ListSave extends BlocEvent {

  final ListadoEventType event;
  final String name;
  final List selected;
  final Cliente user;


  ListSave({
    @required this.event,
    @required this.name,
    @required this.selected,
    @required this.user,
  });
}

enum ListadoEventType {
  none,
  working,
  savingList,
}
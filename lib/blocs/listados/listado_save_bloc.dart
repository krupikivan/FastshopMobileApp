import 'dart:async';

import 'package:fastshop/bloc_helpers/bloc_event_state.dart';
import 'package:fastshop/blocs/listados/listado_event.dart';
import 'package:fastshop/blocs/listados/listado_state.dart';
import 'package:fastshop/repos/listado_provider.dart';

class ListSaveBloc extends BlocEventStateBase<ListSave, ListadoState> {
  ListSaveBloc()
      : super(
          initialState: ListadoState.noAction(),
        );

  @override
  Stream<ListadoState> eventHandler(
      ListSave event, ListadoState currentState) async* {
    if (event.event == ListadoEventType.savingList) {
      yield ListadoState.savingList();

      ListadoProvider listadoProvider = new ListadoProvider();
      try {
        await listadoProvider.addList(event.name, event.selected, event.user);
      } catch (error) {
        yield ListadoState.failure();
      }

      await Future.delayed(const Duration(seconds: 1));

      yield ListadoState.success();
    }
  }
}

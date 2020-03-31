import 'dart:async';

import 'package:fastshop_mobile/bloc_helpers/bloc_event_state.dart';
import 'package:fastshop_mobile/blocs/listados/listado_event.dart';
import 'package:fastshop_mobile/blocs/listados/listado_state.dart';
import 'package:fastshop_mobile/repos/listado_provider.dart';

class ListadoDeleteBloc extends BlocEventStateBase<ListDelete, ListadoState> {


  ListadoDeleteBloc()
      : super(
          initialState: ListadoState.noAction(),
        );

  @override
  Stream<ListadoState> eventHandler(ListDelete event, ListadoState currentState) async* {
    if (event.event == ListadoEventType.working){
      yield ListadoState.running();


      ListadoProvider listadoProvider = new ListadoProvider();
      try{

        await listadoProvider.deleteUserList(
            idListado: event.idList,
        );
      }catch (error) {
        yield ListadoState.failure();
      }

      await Future.delayed(const Duration(seconds: 1));

      yield ListadoState.success();
    }
  }
}
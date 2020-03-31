import 'package:fastshop_mobile/bloc_helpers/bloc_event_state.dart';

class ListadoState extends BlocState {
  ListadoState({
    this.isRunning: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.isSavingList: false,
  });

  final bool isRunning;
  final bool isSuccess;
  final bool isFailure;
  final bool isSavingList;

  factory ListadoState.noAction() {
    return ListadoState();
  }

  factory ListadoState.running(){
    return ListadoState(isRunning: true,);
  }

  factory ListadoState.savingList(){
    return ListadoState(isSavingList: true,);
  }

  factory ListadoState.success(){
    return ListadoState(isSuccess: true,);
  }

  factory ListadoState.failure(){
    return ListadoState(isFailure: true,);
  }

}
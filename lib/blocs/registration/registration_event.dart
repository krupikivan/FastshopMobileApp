import 'package:fastshop_mobile/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class RegistrationEvent extends BlocEvent {

  final RegistrationEventType event;
  final String nombre;
  final String apellido;
  final String email;
  final String password;

  RegistrationEvent({
    @required this.apellido, 
    @required this.event,
    @required this.nombre,
    @required this.email,
    @required this.password,
  });

}

enum RegistrationEventType {
  none,
  working,
}
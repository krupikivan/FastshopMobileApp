import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/registration/registration_bloc.dart';
import 'package:fastshop/blocs/registration/registration_event.dart';
import 'package:fastshop/blocs/registration/registration_form_bloc.dart';
import 'package:fastshop/blocs/registration/registration_state.dart';
import 'package:fastshop/design/colors.dart';
import 'package:fastshop/widgets/pending_action.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController _nombreController;
  TextEditingController _apellidoController;
  TextEditingController _emailController;
  TextEditingController _passController;
  TextEditingController _passRetypeController;
  RegistrationFormBloc _registrationFormBloc;
  RegistrationBloc _registrationBloc;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: '');
    _apellidoController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    _passController = TextEditingController(text: '');
    _passRetypeController = TextEditingController(text: '');
    _registrationFormBloc = RegistrationFormBloc();
    _registrationBloc = RegistrationBloc();
  }

  @override
  void dispose() {
    _registrationBloc?.dispose();
    _registrationFormBloc?.dispose();
    _nombreController?.dispose();
    _apellidoController?.dispose();
    _emailController?.dispose();
    _passController?.dispose();
    _passRetypeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<RegistrationState>(
        bloc: _registrationBloc,
        builder: (BuildContext context, RegistrationState state) {
          if (state.isBusy) {
            return PendingAction();
          } else if (state.isSuccess) {
            return _buildSuccess();
          } else if (state.isFailure) {
            return _buildFailure();
          }
          return _buildForm();
        });
  }

  Widget _buildSuccess() {
    return AlertDialog(
      title: Text('Exitoso'),
      content: const Text('El usuario ha sido registrado'),
      actions: <Widget>[
        OutlinedButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildFailure() {
    return AlertDialog(
      title: Text('Error'),
      content: const Text('Error en la creacion del usuario'),
      actions: <Widget>[
        OutlinedButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Fastshop - Registrate'),
      ),
      body: new Form(
        child: Container(
          constraints: new BoxConstraints.expand(),
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(height: 20),
                  //NOMBRE
                  StreamBuilder<String>(
                      stream: _registrationFormBloc.nombre,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return new Container(
                          height: 100.0,
                          child: new ListTile(
                            leading: const Icon(Icons.account_circle),
                            title: TextField(
                              decoration: new InputDecoration(
                                labelText: 'Nombre',
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                errorText: snapshot.error,
                              ),
                              controller: _nombreController,
                              onChanged: _registrationFormBloc.onNombreChanged,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        );
                      }),

                  //APELLIDO
                  StreamBuilder<String>(
                      stream: _registrationFormBloc.apellido,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return new Container(
                          height: 100.0,
                          child: new ListTile(
                            leading: const Icon(Icons.account_circle),
                            title: TextField(
                              decoration: new InputDecoration(
                                labelText: 'Apellido',
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                errorText: snapshot.error,
                              ),
                              controller: _apellidoController,
                              onChanged: _registrationFormBloc.onNombreChanged,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        );
                      }),

                  //EMAIL
                  StreamBuilder<String>(
                      stream: _registrationFormBloc.email,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return new Container(
                          height: 100.0,
                          child: ListTile(
                            leading: const Icon(Icons.email),
                            title: TextField(
                              decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                labelText: 'Email',
                                errorText: snapshot.error,
                              ),
                              controller: _emailController,
                              onChanged: _registrationFormBloc.onEmailChanged,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        );
                      }),

                  //PASSWORD
                  StreamBuilder<String>(
                      stream: _registrationFormBloc.password,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return new Container(
                          height: 100.0,
                          child: ListTile(
                            leading: const Icon(Icons.remove_red_eye),
                            title: TextField(
                              decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                labelText: 'Contraseña',
                                errorText: snapshot.error,
                              ),
                              controller: _passController,
                              obscureText: true,
                              onChanged:
                                  _registrationFormBloc.onPasswordChanged,
                            ),
                          ),
                        );
                      }),

                  //RETYPE PASSWORD
                  StreamBuilder<String>(
                      stream: _registrationFormBloc.confirmPassword,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return new Container(
                          height: 100.0,
                          child: ListTile(
                            leading: const Icon(Icons.repeat),
                            title: TextField(
                              decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                labelText: 'Repita contraseña',
                                errorText: snapshot.error,
                              ),
                              controller: _passRetypeController,
                              obscureText: true,
                              onChanged:
                                  _registrationFormBloc.onRetypePasswordChanged,
                            ),
                          ),
                        );
                      }),

                  //FORM BLOC
                  StreamBuilder<bool>(
                      stream: _registrationFormBloc.registerValid,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return new ButtonTheme(
                          child: new ButtonBar(children: <Widget>[
                            new SizedBox(
                              height: 48.0,
                              child: new InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: 140,
                                    height: 48.8,
                                    child: Center(
                                      child: const Text(
                                        "Registrar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _registrationBloc.emitEvent(
                                        RegistrationEvent(
                                            event:
                                                RegistrationEventType.working,
                                            nombre: _nombreController.text,
                                            apellido: _apellidoController.text,
                                            email: _emailController.text,
                                            password: _passController.text));
                                  }
                                  // : null,
                                  ),
                            ),
                            new SizedBox(
                              height: 48.0,
                              child: new InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: 140,
                                  height: 48.8,
                                  child: Center(
                                    child: const Text(
                                      "Borrar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _clearForm();
                                },
                              ),
                            ),
                          ]),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clearForm() {
    _nombreController.clear();
    _apellidoController.clear();
    _emailController.clear();
    _passController.clear();
    _passRetypeController.clear();
  }
}

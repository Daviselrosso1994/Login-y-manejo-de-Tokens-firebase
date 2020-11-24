import 'package:flutter/material.dart';
import 'package:validacion_formulario_login/src/patronBloc/provider_InheritedWidget.dart';

class DatosUruarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Aquí buscamos la instancia MyInheritedWidget porque ahi
    //esta inicializada la instancia del LoginBloc();
    final bloc = MyInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del Usuario'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${bloc.latestEmail}'),
            Text('Email: ${bloc.latestPassword}'),
          ],
        ),
      ),
    );
  }
}

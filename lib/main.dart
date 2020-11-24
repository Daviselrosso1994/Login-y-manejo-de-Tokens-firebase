import 'package:flutter/material.dart';
import 'package:validacion_formulario_login/src/patronBloc/provider_InheritedWidget.dart';
import 'package:validacion_formulario_login/src/pages/login_page.dart';
import 'package:validacion_formulario_login/src/pages/home_page.dart';
import 'package:validacion_formulario_login/src/pages/datos_usuario_page.dart';
import 'package:validacion_formulario_login/src/pages/registro_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      //El key y child deriva de:
      //MyInheritedWidget({Key key, Widget child})
      //Widget child puede ser cualquier widget, en este caso es el MaterialApp(),
      key: key,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'datosUsuario': (BuildContext context) => DatosUruarioPage(),
          'registro': (BuildContext context) => RegistroPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

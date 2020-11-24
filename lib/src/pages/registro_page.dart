import 'package:flutter/material.dart';
import 'package:validacion_formulario_login/src/patronBloc/provider_InheritedWidget.dart';
import 'package:validacion_formulario_login/src/providers/usuario_provider.dart';

class RegistroPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _fondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      //40% de la pantalla:
      height: size.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(120, 70, 178, 1.0),
          ],
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.07),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 60.0, child: circulo),
        Positioned(top: -40.0, left: -30.0, child: circulo),
        Positioned(bottom: 130.0, right: 60.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: -50.0, left: -30.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 45.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text(
                'Christian Salazar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    //Aquí buscamos la instancia MyInheritedWidget porque ahi
    //esta inicializada la instancia del LoginBloc();
    final bloc = MyInheritedWidget.of(context);

    final size = MediaQuery.of(context).size;

    //SingleChildScrollView crea un cuadro en el que se
    //puede desplazar un solo widget:
    //Nos permite hacer scroll dependiendo del alto del child:
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Registro de Usuario',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 40.0),
                //Mandamos la referencia o argumento de bloc:
                _campoEmail(bloc),
                SizedBox(height: 30.0),
                //Mandamos la referencia o argumento de bloc:
                _campoPassword(bloc),
                SizedBox(height: 30.0),
                _boton(bloc),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            child: Text('¿Ya tienes usuario? Inicia Sesión',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  //Para usar LoginBloc bloc como argumento utilizamos la export del provider_InheritedWidget.dart
  Widget _campoEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'nombre@hotmail.com',
              labelText: 'Correo electronico',

              ///Muestra el sink.addError de la condición de validarPassword en
              ///validaciones.dart
              ///Hacer el stream.transform(validarEmail); en el login_bloc.dart
              errorText: snapshot.error,

              ///Esta es la salida de valor (value) ingresada en el stream
              ///por medio del onChanged: bloc.email.
              ///Mediante el stream escucha los cambios del campo email.
              ///NOTA IMPORTANTE: Notese que estamos redibujando el Widget
              ///usando un StatelessWidget y no un StatefullWidget:
              counterText: snapshot.data,
            ),

            ///Gracias al InheritedWidget podemos escuchar los cambios
            ///ocurridos en el TextField y mandarlos de la siguiente manera:
            ///El onChanged recibe un valor (correo) == (value) y dispara la
            ///accion bloc.email(value) que crea la entrada en el stream
            onChanged: bloc.email,
            //Otra forma: onChanged: (value) => bloc.email(value),
          ),
        );
      },
    );
  }

  //Para usar LoginBloc bloc como argumento utilizamos la export del provider_InheritedWidget.dart
  Widget _campoPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Password',

              ///Muestra el sink.addError de la condición de validarPassword
              ///validaciones.dart
              ///Hacer el stream.transform(validarPassword); en el login_bloc.dart
              errorText: snapshot.error,

              ///Esta es la salida de valor (value) ingresada en el stream
              ///por medio del onChanged: bloc.password.
              ///Mediante el stream escucha los cambios del campo password.
              ///NOTA IMPORTANTE: Notese que estamos redibujando el Widget
              ///usando un StatelessWidget y no un StatefullWidget:
              counterText: snapshot.data,
            ),

            ///Gracias al InheritedWidget podemos escuchar los cambios
            ///ocurridos en el TextField y mandarlos de la siguiente manera:
            ///El onChanged recibe un valor (password) == (value) y dispara la
            ///accion bloc.password(value) que crea la entrada en el stream
            onChanged: bloc.password,
            //Otra forma: onChanged: (value) => bloc.password(value),
          ),
        );
      },
    );
  }

  //Para usar LoginBloc bloc como argumento utilizamos la export del provider_InheritedWidget.dart
  Widget _boton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            child: Text(
              'Ingresar',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 3.0,
          color: Colors.deepPurple,
          textColor: Colors.white,

          ///Si en el formValidStream la información de ambos campos
          ///no es verdadera el snapshot no tiene data, usamos el operador
          ///ternario para decir:
          ///si el snapshot tiene dara entonces habilita el boton (){}
          ///caso contrario igual a null: desabilita el boton:
          onPressed: snapshot.hasData ? () => _registro(context, bloc) : null,
        );
      },
    );
  }

  _registro(BuildContext contex, LoginBloc bloc) {
    usuarioProvider.nuevoUsuario(bloc.latestEmail, bloc.latestEmail);
  }
}

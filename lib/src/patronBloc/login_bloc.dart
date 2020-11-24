import 'dart:async';
import 'package:rxdart/rxdart.dart'; //https://pub.dev/packages/rxdart
import 'package:validacion_formulario_login/src/patronBloc/validaciones.dart'; //StreamController

//with Validaciones crea un mixin:
class LoginBloc with Validaciones {
  ///StringController que permiten controlar el correo y el password:
  ///Se utiliza el broadcast para que pueda ser escuchado en varias instancias.

  ///Nota importante: rxdart no trabaja con StreamController sino con
  ///BehaviorSubject que tienen incrustado su broadcast.
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Get para insertar valores al stream
  Function(String) get email => _emailController.sink.add;
  Function(String) get password => _passwordController.sink.add;

  //Get para escuchar los datos del stream
  Stream<String> get emailStream =>
      //Se implementa el .transform(validarEmail) gracias al with Validaciones:
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      //Se implementa el .transform(validarPassword) gracias al with Validaciones:
      _passwordController.stream.transform(validarPassword);

  ///Get para validar los datos del stream:
  ///Esto sirve para bloquear el boton de ingresar en el login cuando
  ///la data no sea correcta y habilitarlo cuando ambos sean validos.
  ///Para esto utilizaremos la libreria rxdart:
  ///https://pub.dev/packages/rxdart/install
  ///rxdart es la implementacion de las extensiones reactivas para dart.
  ///rxdart nos permite mezclar dos o mas streams mediante su clase:

  ///CombineLatestStream<T, R> class la cual tiene los siguientes metodos:
  ///STATIC METHODS
  ///combine2, combine3, combine4, combine5, combine6, combine7, combine8, combine9.

  ///Diagramas interactivos de Rx Observables
  ///https://rxmarbles.com/#combineLatest
  ///Clase: 204. Combinar Streams de Flutter: Tu guía completa de desarrollo para IOS y Android.

  ///Nota importante: rxdart no trabaja con StreamController sino con
  ///BehaviorSubject que tienen incrustado su broadcast.

  ///En este caso en especifico vamos a utilizar el CombineLatestStream combine2
  ///porque solo queremos combinar 2 stream.
  ///https://pub.dev/documentation/rxdart/latest/rx/CombineLatestStream/combine2.html
  Stream<bool> get formValidStream =>
      //si tenemos data valida en ambos stream (e,p) regresamos un true, caso contrario un null.
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Obtener el ultimo valor ingresado en los Streams
  String get latestEmail => _emailController.value;
  String get latestPassword => _passwordController.value;

  //Metodo para cerrar los stream cuando ya no se los necesita:
  dispose() {
    // ?  si _emailController o _passwordController es null no se ejecuta el .close();
    _emailController?.close();
    _passwordController?.close();
  }
}

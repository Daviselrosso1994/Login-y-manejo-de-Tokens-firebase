import 'dart:async';

//StreamTransformer para alidaciones.
class Validaciones {
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      //
      Pattern patron =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = RegExp(patron);

      ///Si la expresión regular RegExp tiene un hasMatch con el email
      ///entonces es un correo valido y se lo deja fluir por el stream.
      ///Caso contrario mostrar mensaje de error:
      ///El email ingresado no es valido

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('El email ingresado no es valido');
      }
    },
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      ///Si el tamaño de caracteres del password es mayor o igual a
      ///6 caracteres enonces validar el password y dejarlo fluir en el stream.
      ///Caso contrario mostrar mensaje de error: Ingresar mas de 6 caracteres

      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError('Ingresar mas de 6 caracteres');
      }
    },
  );
}

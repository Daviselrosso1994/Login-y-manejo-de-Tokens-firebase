import 'dart:convert'; //json.encode

import 'package:http/http.dart' as http;

class UsuarioProvider {
  //Configuración de proyecto en Firebase/Clave de API web:
  final String _firebaseToken = 'AIzaSyDGwrk4bCVr3T5D15fvDL-bu0C2YbsEj7k';

  //Metodo Regístrar usuario con correo electrónico / contraseña:
  //https://firebase.google.com/docs/reference/rest/auth
  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authenticData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final respuesta = await http.post(
      //https://firebase.google.com/docs/reference/rest/auth#section-create-email-password    (Sign up with email / password)
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authenticData),
    );

    Map<String, dynamic> decodeResp = json.decode(respuesta.body);

    ///Se imprime en consola el decodeResp:
    print(decodeResp);

    ///si decodeResp es un email y password valido entonces contiene:
    ///I/flutter (15121): {kind:..................., idToken:..................., email: (email ingresado), refreshToken:................}

    ///si decodeResp es un email y password repetido entonces contiene:
    ///I/flutter (15121): {error: {code: 400, message: EMAIL_EXISTS, errors: [{message: EMAIL_EXISTS, domain: global, reason: invalid}]}}

    if (decodeResp.containsKey('idToken')) {
      //si decodeResp es un email y password valido entonces contiene:
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      //si decodeResp es un email y password repetido entonces contiene:
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }

  //Metodo Iniciar sesión con correo electrónico / contraseña:
  //https://firebase.google.com/docs/reference/rest/auth
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authenticData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final respuesta = await http.post(
      //https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password   (Sign in with email / password)
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authenticData),
    );

    Map<String, dynamic> decodeResp = json.decode(respuesta.body);

    ///Se imprime en consola el decodeResp:
    print(decodeResp);

    ///si decodeResp es un email y password valido entonces contiene:
    ///I/flutter (15121): {kind:..................., idToken:..................., email: (email ingresado), refreshToken:................}

    ///si decodeResp es un email y password repetido entonces contiene:
    ///I/flutter (15121): {error: {code: 400, message: EMAIL_EXISTS, errors: [{message: EMAIL_EXISTS, domain: global, reason: invalid}]}}

    if (decodeResp.containsKey('idToken')) {
      //si decodeResp es un email y password valido entonces contiene:
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      //si decodeResp es un email y password repetido entonces contiene:
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }
}

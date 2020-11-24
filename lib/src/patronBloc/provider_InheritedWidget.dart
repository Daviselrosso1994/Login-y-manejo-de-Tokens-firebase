import 'package:flutter/material.dart';
import 'package:validacion_formulario_login/src/patronBloc/login_bloc.dart';
//Exportamos: Para que donde sea que utilizemos MyInheritedWidget tenga implicito el LoginBloc();
export 'package:validacion_formulario_login/src/patronBloc/login_bloc.dart';

///Clase InheritedWidget
///Clase base para widgets que propaga información de manera
///eficiente por el árbol de Widgets. Para obtener la instancia
///más cercana de un tipo particular de widget heredado de un contexto
///de compilación, use BuildContext.dependOnInheritedWidgetOfExactType.
///Los widgets heredados, cuando se hace referencia a ellos de esta
///manera, harán que el consumidor reconstruya cuando el propio
///widget heredado cambie de estado.
///
///InheritedWidget es una herramienta que Flutter proporciona
///para ayudar con este tema de la hidratación del árbol de
///widgets. InheritedWidgets permite a los widgets situados en
///la parte inferior del árbol mirar hacia arriba, obtener una
/// referencia a un antepasado, y también reconstruirse cada
/// vez que ese antepasado cambia.
///
///https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
///https://www.youtube.com/watch?v=Zbm3hjPjQMk&feature=emb_logo
///https://www.youtube.com/watch?v=ml5uefGgkaA
///
///Nota: InheritedWidget es solo una forma de manejo o administración
///de estados (State management):
///https://flutter.dev/docs/development/data-and-backend/state-mgmt

class MyInheritedWidget extends InheritedWidget {
  //Creación de la unica instancia para manejar LoginBloc();
  final loginBloc = LoginBloc();
  //() Aqui podemos colocar otras instancias de propiedad a utilizar en la app.

  static MyInheritedWidget _instancia;

  //El factory determina si regresar una nueva instancia de la clase
  //o la que ya existe.
  factory MyInheritedWidget({Key key, Widget child}) {
    if (_instancia == null) {
      ///MyInheritedWidget llama a un constructor privado llamado _internal:
      ///para prevenir que se pueda inicializar esta clase desde afuera del
      ///MyInheritedWidget.
      _instancia = MyInheritedWidget._internal(key: key, child: child);
    }
    return _instancia;
  }
  //Constructor privado:
  //Inicializamos el InheritedWidget de la siguiente manera: super(key: key, child: child);
  MyInheritedWidget._internal({Key key, Widget child})
      : super(key: key, child: child);

  ///@override (sobrescritura) de updateShouldNotify que es un metodo
  ///que se encarga de notificar a todos los hijos cuando sea necesario
  ///(cuando existe una mutación de u widget en especifico)

  ///¿Al actualizarse debe notificar a todos sus hijos? => true;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //Si tenemos mas instancias por usar, repetimos este fragmento:
  //Solamante cambiamos el LoginBloc of por otro nombre.
  static LoginBloc of(BuildContext context) {
    ///Dependencia del widget heredado de tipo exacto:
    ///Este return lo que hace es escalar el arbol de Widgets hasta
    ///encontrar la instancia de MyInheritedWidget la cual esta en la
    ///parte superior del arbol y apuntara hacia el loginBloc.
    return context
        .dependOnInheritedWidgetOfExactType<MyInheritedWidget>()
        .loginBloc;
  }
}

///Nota: MyInheritedWidget lo utilizamos en la parte superior del
///arbol de Widgets:

/*

return MyInheritedWidget(
  child: MaterialApp(),
);

*/

//Para validación del campo _precio en mis_productos_page.dart
bool isNumeric(String string) {
  //si el valor recbido (string) esta vacio => false
  if (string.isEmpty) return false;
  //Convertimos el valor recibido de tipo string en un numero.
  final n = num.tryParse(string);
  //si n es null => falso, caso contrario true;
  return (n == null) ? false : true;
}

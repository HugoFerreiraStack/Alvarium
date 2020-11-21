import 'package:alvarium/app/shared/model/formulario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FormController {
  final void Function(String) callBack;

  static const String URL =
      "https://script.google.com/macros/s/AKfycbyJkUTDC8gIRwiDB5pUu16qgP9Hf4iNg65rJzTx0_RAuDPI4Cs/exec";

  static const STATUS_SUCCESS = "Sucesso";

  FormController(this.callBack);

  void submitForm(Formulario formulario) async {
    try {
      await http.get(URL + formulario.toParams()).then((response) {
        callBack(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}

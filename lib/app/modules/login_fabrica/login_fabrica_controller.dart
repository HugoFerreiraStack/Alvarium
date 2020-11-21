import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_fabrica_controller.g.dart';

@Injectable()
class LoginFabricaController = _LoginFabricaControllerBase
    with _$LoginFabricaController;

abstract class _LoginFabricaControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

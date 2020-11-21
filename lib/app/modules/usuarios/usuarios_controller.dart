import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'usuarios_controller.g.dart';

@Injectable()
class UsuariosController = _UsuariosControllerBase with _$UsuariosController;

abstract class _UsuariosControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

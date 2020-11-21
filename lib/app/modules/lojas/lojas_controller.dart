import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'lojas_controller.g.dart';

@Injectable()
class LojasController = _LojasControllerBase with _$LojasController;

abstract class _LojasControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

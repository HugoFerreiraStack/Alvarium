import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'reaproveitamento_controller.g.dart';

@Injectable()
class ReaproveitamentoController = _ReaproveitamentoControllerBase
    with _$ReaproveitamentoController;

abstract class _ReaproveitamentoControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'fabrica_controller.g.dart';

@Injectable()
class FabricaController = _FabricaControllerBase with _$FabricaController;

abstract class _FabricaControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

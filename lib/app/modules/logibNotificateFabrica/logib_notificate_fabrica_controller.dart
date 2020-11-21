import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'logib_notificate_fabrica_controller.g.dart';

@Injectable()
class LogibNotificateFabricaController = _LogibNotificateFabricaControllerBase
    with _$LogibNotificateFabricaController;

abstract class _LogibNotificateFabricaControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

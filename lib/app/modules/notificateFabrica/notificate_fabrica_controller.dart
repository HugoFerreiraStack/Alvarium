import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'notificate_fabrica_controller.g.dart';

@Injectable()
class NotificateFabricaController = _NotificateFabricaControllerBase
    with _$NotificateFabricaController;

abstract class _NotificateFabricaControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

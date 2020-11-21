import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'selection_controller.g.dart';

@Injectable()
class SelectionController = _SelectionControllerBase with _$SelectionController;

abstract class _SelectionControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

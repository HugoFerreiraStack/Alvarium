import 'notificate_fabrica_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'notificate_fabrica_page.dart';

class NotificateFabricaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $NotificateFabricaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => NotificateFabricaPage()),
      ];

  static Inject get to => Inject<NotificateFabricaModule>.of();
}

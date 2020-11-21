import 'logib_notificate_fabrica_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'logib_notificate_fabrica_page.dart';

class LogibNotificateFabricaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $LogibNotificateFabricaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => LogibNotificateFabricaPage()),
      ];

  static Inject get to => Inject<LogibNotificateFabricaModule>.of();
}

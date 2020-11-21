import 'login_fabrica_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_fabrica_page.dart';

class LoginFabricaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $LoginFabricaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => LoginFabricaPage()),
      ];

  static Inject get to => Inject<LoginFabricaModule>.of();
}

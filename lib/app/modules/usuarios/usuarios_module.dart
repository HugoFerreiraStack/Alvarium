import 'package:flutter/src/widgets/framework.dart';

import 'usuarios_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'usuarios_page.dart';

class UsuariosModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        $UsuariosController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => UsuariosPage()),
      ];

  static Inject get to => Inject<UsuariosModule>.of();

  @override
  // TODO: implement view
  Widget get view => UsuariosPage();
}

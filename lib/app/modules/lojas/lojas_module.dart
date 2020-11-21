import 'package:flutter/src/widgets/framework.dart';

import 'lojas_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'lojas_page.dart';

class LojasModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        $LojasController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LojasPage()),
      ];

  static Inject get to => Inject<LojasModule>.of();

  @override
  // TODO: implement view
  Widget get view => LojasPage();
}

import 'package:flutter/src/widgets/framework.dart';

import 'pedidos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pedidos_page.dart';

class PedidosModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        $PedidosController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => PedidosPage()),
      ];

  static Inject get to => Inject<PedidosModule>.of();

  @override
  // TODO: implement view
  Widget get view => PedidosPage();
}

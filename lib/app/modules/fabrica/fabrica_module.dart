import 'package:alvarium/app/modules/fabrica/fabrica_page_ind_shop.dart';

import 'fabrica_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'fabrica_page.dart';

class FabricaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $FabricaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => FabricaPage()),
        ModularRouter('/ind_shop', child: (_, args) => PedidosIndSHopdPage())
      ];

  static Inject get to => Inject<FabricaModule>.of();
}

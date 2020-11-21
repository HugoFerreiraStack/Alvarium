import 'package:flutter/src/widgets/framework.dart';

import 'produtos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'produtos_page.dart';

class ProdutosModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        $ProdutosController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ProdutosPage()),
      ];

  static Inject get to => Inject<ProdutosModule>.of();

  @override
  // TODO: implement view
  Widget get view => ProdutosPage();
}

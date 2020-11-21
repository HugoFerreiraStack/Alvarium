import 'package:flutter/src/widgets/framework.dart';

import 'reaproveitamento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'reaproveitamento_page.dart';

class ReaproveitamentoModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        $ReaproveitamentoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ReaproveitamentoPage()),
      ];

  static Inject get to => Inject<ReaproveitamentoModule>.of();

  @override
  // TODO: implement view
  Widget get view => ReaproveitamentoPage();
}

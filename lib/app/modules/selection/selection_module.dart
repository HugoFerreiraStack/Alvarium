import 'selection_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'selection_page.dart';

class SelectionModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $SelectionController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => SelectionPage()),
      ];

  static Inject get to => Inject<SelectionModule>.of();
}

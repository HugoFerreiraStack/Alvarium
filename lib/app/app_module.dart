import 'package:alvarium/app/modules/fabrica/fabrica_module.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_ind_shop.dart';
import 'package:alvarium/app/modules/logibNotificateFabrica/logib_notificate_fabrica_module.dart';
import 'package:alvarium/app/modules/login/login_module.dart';
import 'package:alvarium/app/modules/login_fabrica/login_fabrica_module.dart';
import 'package:alvarium/app/modules/lojas/lojas_module.dart';
import 'package:alvarium/app/modules/notificateFabrica/notificate_fabrica_module.dart';
import 'package:alvarium/app/modules/pedidos/pedidos_module.dart';
import 'package:alvarium/app/modules/pedidos/pedidos_page_carrinho.dart';
import 'package:alvarium/app/modules/produtos/produtos_module.dart';
import 'package:alvarium/app/modules/selection/selection_module.dart';
import 'package:alvarium/app/modules/start/start_module.dart';
import 'package:alvarium/app/modules/usuarios/usuarios_module.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:alvarium/app/app_widget.dart';
import 'package:alvarium/app/modules/home/home_module.dart';

import 'shared/pages/splash_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashPage()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/login_fabrica', module: LoginFabricaModule()),
        ModularRouter('/start', module: StartModule()),
        ModularRouter('/fabrica', module: FabricaModule()),
        ModularRouter('/ind_shop', child: (_, args) => PedidosIndSHopdPage()),
        ModularRouter('/selection', module: SelectionModule()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/lojas', module: LojasModule()),
        ModularRouter('/pedidos', module: PedidosModule()),
        ModularRouter('/carrinho', child: (_, args) => FinalizarPedidoPage()),
        ModularRouter('/produtos', module: ProdutosModule()),
        ModularRouter('/usuarios', module: UsuariosModule()),
        ModularRouter('/not_fab', module: NotificateFabricaModule()),
        ModularRouter('/login_not_fab', module: LogibNotificateFabricaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

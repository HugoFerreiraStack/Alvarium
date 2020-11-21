import 'package:alvarium/app/modules/home/home_module.dart';
import 'package:alvarium/app/modules/lojas/lojas_module.dart';
import 'package:alvarium/app/modules/pedidos/pedidos_module.dart';
import 'package:alvarium/app/modules/produtos/produtos_module.dart';
import 'package:alvarium/app/modules/reaproveitamento/reaproveitamento_module.dart';
import 'package:alvarium/app/modules/usuarios/usuarios_module.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'start_controller.dart';

class StartPage extends StatefulWidget {
  final String title;
  const StartPage({Key key, this.title = "Start"}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends ModularState<StartPage, StartController> {
  //use 'controller' variable to access controller

  List widgetOptions = [
    HomeModule(),
    UsuariosModule(),
    ProdutosModule(),
    ReaproveitamentoModule(),
    PedidosModule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return widgetOptions.elementAt(controller.currentIndex);
        },
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return Observer(builder: (_) {
      return CurvedNavigationBar(
        index: controller.currentIndex,
        onTap: (index) {
          controller.upDateCurrentIndex(index);
        },
        items: <Widget>[
          Icon(Icons.home_filled, size: 30, color: Palette.gold),
          Icon(Icons.person, size: 30, color: Palette.gold),
          Icon(Icons.fastfood, size: 30, color: Palette.gold),
          Icon(Icons.sync, size: 30, color: Palette.gold),
          Icon(Icons.shopping_cart, size: 30, color: Palette.gold),
        ],
        color: Palette.black,
        buttonBackgroundColor: Palette.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
      );
    });
  }
}

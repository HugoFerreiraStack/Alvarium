import 'package:alvarium/app/shared/custom_cliper.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'reaproveitamento_controller.dart';

class ReaproveitamentoPage extends StatefulWidget {
  final String title;
  const ReaproveitamentoPage({Key key, this.title = "Reaproveitamento"})
      : super(key: key);

  @override
  _ReaproveitamentoPageState createState() => _ReaproveitamentoPageState();
}

class GrupoDeProduto {
  int id;
  String nomeDoGrupo;

  GrupoDeProduto(this.id, this.nomeDoGrupo);

  static List<GrupoDeProduto> getGrupos() {
    return <GrupoDeProduto>[
      GrupoDeProduto(1, 'Bolos'),
      GrupoDeProduto(2, 'Doces da Casa'),
      GrupoDeProduto(3, 'Doces Finos'),
      GrupoDeProduto(4, 'Tortas Frias'),
      GrupoDeProduto(5, 'Salgados Grandes'),
      GrupoDeProduto(6, 'Salgados Mini'),
      GrupoDeProduto(7, 'Diversos'),
      GrupoDeProduto(8, 'Biscoitos'),
    ];
  }
}

class _ReaproveitamentoPageState
    extends ModularState<ReaproveitamentoPage, ReaproveitamentoController> {
  //use 'controller' variable to access controller
  List<GrupoDeProduto> _grupoDeProduto = GrupoDeProduto.getGrupos();
  List<DropdownMenuItem<GrupoDeProduto>> _dropDownMenuItens;
  GrupoDeProduto _grupoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
            title: Text(
              "Reaproveitamento e Doação",
              style: TextStyle(
                color: Palette.gold2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: ClipPath(
              clipper: MyCustomClipperForAppBar(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Palette.gold, Palette.black],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        tileMode: TileMode.clamp)),
              ),
            )),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    "Selecione o Grupo de Produto",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

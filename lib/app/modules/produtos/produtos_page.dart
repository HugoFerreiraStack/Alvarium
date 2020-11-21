import 'package:alvarium/app/modules/start/start_controller.dart';
import 'package:alvarium/app/shared/custom_cliper.dart';
import 'package:alvarium/app/shared/model/produto_model.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'produtos_controller.dart';

class ProdutosPage extends StatefulWidget {
  final String title;
  const ProdutosPage({Key key, this.title = "Produtos"}) : super(key: key);

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
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

class _ProdutosPageState
    extends ModularState<ProdutosPage, ProdutosController> {
  //use 'controller' variable to access controller
  TextEditingController _codigoProduto = TextEditingController();
  TextEditingController _nomeProduto = TextEditingController();
  TextEditingController _descricaoProduto = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String codigo;
  String nome;
  String descricao;
  String grupoSelecionado;
  Produto _produto;
  BuildContext _dialogContext;
  String _itemSelecionadoGrupos;
  String mensagem = "";

  List<GrupoDeProduto> _grupoDeProduto = GrupoDeProduto.getGrupos();
  List<DropdownMenuItem<GrupoDeProduto>> _dropDownMenuItens;
  GrupoDeProduto _grupoSelecionado;

  _cadastrarProduto() async {
    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    String idUsuarioLogado = usuarioLogado.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Meus Produtos").doc(_produto.id).set(_produto.toMap());
  }

  @override
  void initState() {
    _dropDownMenuItens = buildDropDownMenuItens(_grupoDeProduto);
    _grupoSelecionado = _dropDownMenuItens[0].value;
    _produto = Produto.gerarID();
    super.initState();
  }

  List<DropdownMenuItem<GrupoDeProduto>> buildDropDownMenuItens(List grupos) {
    List<DropdownMenuItem<GrupoDeProduto>> itens = List();
    for (GrupoDeProduto grupo in grupos) {
      itens.add(
        DropdownMenuItem(
          value: grupo,
          child: Text(grupo.nomeDoGrupo),
        ),
      );
    }
    return itens;
  }

  onChangeDropDownItem(GrupoDeProduto grupoSelecionado) {
    setState(() {
      _grupoSelecionado = grupoSelecionado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
            title: Text(
              "Cadastro de Produtos",
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Digite o código do Produto",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onSaved: (codigo) {
                    _produto.codigo = codigo;
                  },
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "O campo é Obrigatorio";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Digite o nome do Produto",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onSaved: (nome) {
                    _produto.nome = nome;
                  },
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "O campo é Obrigatorio";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Selecione o grupo de Produtos"),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: _grupoSelecionado,
                  items: _dropDownMenuItens,
                  onChanged: onChangeDropDownItem,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      setState(() {
                        codigo = _codigoProduto.text;
                        nome = _nomeProduto.text;
                        descricao = _descricaoProduto.text;
                        grupoSelecionado =
                            _grupoSelecionado.nomeDoGrupo.toString();
                        _produto.codigo = codigo;
                        _produto.nome = nome;
                        _produto.statusPedido = false;
                        _produto.grupoProduto = grupoSelecionado;
                        _produto.status = "";
                        _produto.quantidade = "0";
                        formKey.currentState.save();
                        _cadastrarProduto();
                        mensagem = "Produto cadastrado com sucesso";
                        formKey.currentState.reset();
                      });
                    }
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(color: Palette.gold2),
                  ),
                  color: Palette.black,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(mensagem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

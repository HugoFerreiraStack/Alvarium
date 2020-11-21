import 'dart:async';

import 'package:alvarium/app/shared/custom_cliper.dart';
import 'package:alvarium/app/shared/model/item_produto.dart';
import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/model/produto_model.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pedidos_controller.dart';

class PedidosPage extends StatefulWidget {
  final String title;
  const PedidosPage({Key key, this.title = "Pedidos"}) : super(key: key);

  @override
  _PedidosPageState createState() => _PedidosPageState();
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

class _PedidosPageState extends ModularState<PedidosPage, PedidosController> {
  //use 'controller' variable to access controller
  String _idUsuarioLogado;
  final _controller = StreamController<QuerySnapshot>.broadcast();
  final _controllerDialog = StreamController.broadcast();
  Pedidos _pedidosItem;
  Pedidos _pedidos;
  String id;
  String nome;
  String quantidade;

  String grupoSelecionadoF;
  Produto _produto;
  String _itemSelecionadoGrupos;
  List<GrupoDeProduto> _categorias = GrupoDeProduto.getGrupos();
  List<DropdownMenuItem<GrupoDeProduto>> _dropDownMenuItems;
  GrupoDeProduto _categoriaSelecionada;

  _recuperarDadosUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    _idUsuarioLogado = usuarioLogado.uid;
  }

  Future<Stream<QuerySnapshot>> _filtrarProdutos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Query query = db.collection("Meus Produtos").orderBy("nome");

    if (grupoSelecionadoF != null) {
      query = query.where("grupo de produtos", isEqualTo: grupoSelecionadoF);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    print(grupoSelecionadoF);

    stream.listen((dados) {
      dados.docs.forEach((element) {
        print(element.data());
      });
      _controller.add(dados);
    });
  }

  Future<Stream<QuerySnapshot>> _addListPedidos() async {
    await _recuperarDadosUsuarioLogado();
    FirebaseFirestore db = FirebaseFirestore.instance;

    Query query = db.collection("Meus Pedidos");

    query = query.where("quantidade", isNotEqualTo: "0");

    Stream<QuerySnapshot> stream = db.collection("Meus Pedidos").snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  Future<Stream<QuerySnapshot>> _addListenerProdutos() async {
    await _recuperarDadosUsuarioLogado();
    FirebaseFirestore db = FirebaseFirestore.instance;

    Stream<QuerySnapshot> stream =
        db.collection("Meus Produtos").orderBy("nome").snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    _recuperarDadosUsuarioLogado();
    _dropDownMenuItems = buildDropDownMenuItens(_categorias);
    _categoriaSelecionada = _dropDownMenuItems[0].value;
    _addListenerProdutos();
    super.initState();
    _filtrarProdutos();
  }

  List<DropdownMenuItem<GrupoDeProduto>> buildDropDownMenuItens(List grupos) {
    List<DropdownMenuItem<GrupoDeProduto>> items = List();
    for (GrupoDeProduto grupo in grupos) {
      items.add(
        DropdownMenuItem(
          value: grupo,
          child: Text(grupo.nomeDoGrupo),
        ),
      );
    }
    return items;
  }

  onChangeDropDownItem(GrupoDeProduto grupoSelecionado) {
    setState(() {
      _categoriaSelecionada = grupoSelecionado;
      grupoSelecionadoF = _categoriaSelecionada.nomeDoGrupo;
      print(grupoSelecionadoF);
      _filtrarProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando Produtos"),
          CircularProgressIndicator()
        ],
      ),
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
              title: Text(
                "Pedidos",
                style: TextStyle(
                  color: Palette.gold2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Palette.gold2,
                ),
                onPressed: () {
                  Modular.to.pushNamed('/carrinho');
                },
              ),
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Filtrar por Grupo de Produtos",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: Center(
                        child: DropdownButton(
                          value: _categoriaSelecionada,
                          items: _dropDownMenuItems,
                          onChanged: onChangeDropDownItem,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              StreamBuilder(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return carregandoDados;
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      QuerySnapshot querySnapshot = snapshot.data;

                      if (querySnapshot.docs.length == 0) {
                        return Container(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "Nenhum produto! :( ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: querySnapshot.docs.length,
                          itemBuilder: (_, indice) {
                            List<DocumentSnapshot> produtos =
                                querySnapshot.docs.toList();
                            DocumentSnapshot documentSnapshot =
                                produtos[indice];
                            Produto produto =
                                Produto.fromDocumentSnapshot(documentSnapshot);
                            return ItemProduto(
                              produto: produto,
                            );
                          },
                        ),
                      );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

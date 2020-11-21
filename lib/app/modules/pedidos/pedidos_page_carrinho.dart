import 'dart:async';

import 'package:alvarium/app/shared/model/item_carrinho.dart';
import 'package:alvarium/app/shared/model/item_pedido.dart';
import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/model/usuario.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

class FinalizarPedidoPage extends StatefulWidget {
  @override
  _FinalizarPedidoPageState createState() => _FinalizarPedidoPageState();
}

class _FinalizarPedidoPageState extends State<FinalizarPedidoPage> {
  String lojaUsuario = "";
  String _idUsuarioLogado;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _verificarUsuarioLogado(String loja) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = await auth.currentUser;

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("Usuarios").doc(user.uid).get();
    String loja = snapshot.get("loja");
    setState(() {
      lojaUsuario = loja.toString();
    });
    print(loja);
  }

  _recuperarDadosUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    _idUsuarioLogado = usuarioLogado.uid;
  }

  _recuperarLoja() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    FirebaseFirestore dbLoja = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbLoja.collection("Usuarios").doc(usuarioLogado.uid).get();
    lojaUsuario = snapshot.get("loja");
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
    await _recuperarLoja();

    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db
        .collection("Pedidos" + lojaUsuario)
        .where("status pedido", isEqualTo: false);

    Stream<QuerySnapshot> stream = query.snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _updateStatus() {}

  @override
  void initState() {
    _recuperarLoja();
    _recuperarDadosUsuarioLogado();
    _verificarUsuarioLogado(lojaUsuario);
    _addListenerProdutos();
    super.initState();
  }

  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando Pedidos"),
          CircularProgressIndicator()
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Meu Pedido",
            style: TextStyle(color: Palette.gold),
          ),
          leading: IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Modular.to.pop();
            },
          ),
          backgroundColor: Palette.black,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
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
                            "Nenhum Pedido",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: querySnapshot.docs.length,
                          itemBuilder: (_, indice) {
                            List<DocumentSnapshot> pedidos =
                                querySnapshot.docs.toList();
                            DocumentSnapshot documentSnapshot = pedidos[indice];
                            Pedidos pedido =
                                Pedidos.fromDocumentSnapshot(documentSnapshot);
                            return ItemCarrinho(pedido: pedido);
                          },
                        ),
                      );
                      return Container();
                  }
                },
              )
            ],
          ),
        ));
  }
}

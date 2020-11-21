import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'produto_model.dart';

class ItemPedido extends StatelessWidget {
  Produto produto;
  Pedidos pedido;
  VoidCallback onTapItem;
  TextEditingController myController = TextEditingController();
  String quantidade;
  String nomeSelecionado;
  Pedidos _pedidos = Pedidos.gerarID();
  String loja;
  String status;
  bool statusPedido;
  Timestamp createdAt;

  ItemPedido({
    @required this.pedido,
    this.produto,
    this.onTapItem,
    this.myController,
    this.quantidade,
    this.nomeSelecionado,
    this.status,
    this.loja,
    this.createdAt,
    this.statusPedido,
  });

  _atualizarStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    FirebaseFirestore dbLoja = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbLoja.collection("Usuarios").doc(usuarioLogado.uid).get();
    loja = snapshot.get("loja");

    _pedidos.status = "Iniciado";
    _pedidos.toMap();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("Meus Pedidos")
        .doc(loja)
        .collection("Pedidos")
        .doc(_pedidos.id)
        .update(_pedidos.toMap());

    db.collection("Pedidos").doc(loja).update(_pedidos.toMap());
  }

  _enviarPedido() async {
    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    FirebaseFirestore dbLoja = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbLoja.collection("Usuarios").doc(usuarioLogado.uid).get();
    loja = snapshot.get("loja");

    if (produto.quantidade == null) {
      produto.quantidade = "0";
    } else {
      _pedidos.quantidade = produto.quantidade;

      _pedidos.nome = produto.nome;
      _pedidos.loja = loja;
      _pedidos.createdAt = Timestamp.now();
      _pedidos.status = "Aguardando Inicio";
      _pedidos.statusPedido = false;

      _pedidos.toMap();
    }

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Meus Pedidos").doc(_pedidos.id).set(_pedidos.toMap());
  }

  _enviarPedidoNotification() async {
    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    FirebaseFirestore dbLoja = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbLoja.collection("Usuarios").doc(usuarioLogado.uid).get();
    loja = snapshot.get("loja");

    _pedidos.quantidade = produto.quantidade;

    _pedidos.nome = produto.nome;
    _pedidos.loja = loja;
    _pedidos.createdAt = Timestamp.now();
    _pedidos.status = "Aguardando Inicio";
    _pedidos.statusPedido = false;

    _pedidos.toMap();

    FirebaseFirestore db = FirebaseFirestore.instance;

    db.collection("Pedidos").doc(_pedidos.id).set(_pedidos.toMap());
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        _enviarPedido();
        _enviarPedidoNotification();

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmar Pedido"),
      content: Text("Tem certeza que deseja adicionar este item ao pedido?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        produto.nome,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      //Text("${produto.descricao} "),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: CheckboxListTile(
                    onChanged: (bool value) {},
                    value: null,
                  )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

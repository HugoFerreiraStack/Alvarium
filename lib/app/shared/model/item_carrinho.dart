import 'package:alvarium/app/modules/pedidos/pedidos_page_carrinho.dart';
import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/model/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemCarrinho extends StatelessWidget {
  Pedidos pedido;
  TextEditingController myController = TextEditingController();
  String quantidade;
  String nomeSelecionado;
  String loja;
  String status;
  bool statusPedido;
  Timestamp createdAt;
  VoidCallback onTapItem;
  Pedidos _pedidos = Pedidos.gerarID();
  Produto produto;

  ItemCarrinho({
    @required this.pedido,
    this.myController,
    this.quantidade,
    this.nomeSelecionado,
    this.loja,
    this.status,
    this.statusPedido,
    this.createdAt,
    this.produto,
    this.onTapItem,
  });

  _deleteData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    FirebaseFirestore dbLoja = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbLoja.collection("Usuarios").doc(usuarioLogado.uid).get();
    loja = snapshot.get("loja");

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Pedidos" + loja).doc(pedido.id).delete();
  }

  _deleteDataMyOrders() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    FirebaseFirestore dbLoja = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbLoja.collection("Usuarios").doc(usuarioLogado.uid).get();
    loja = snapshot.get("loja");

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Meus Pedidos").doc(pedido.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16),
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
                        pedido.nome,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        pedido.quantidade,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    _deleteData();
                    _deleteDataMyOrders();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

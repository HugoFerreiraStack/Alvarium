import 'dart:io';

import 'package:alvarium/app/shared/model/controller.dart';
import 'package:alvarium/app/shared/model/formulario.dart';
import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/model/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

enum UploadType {
  /// Uploads a randomly generated string (as a file) to Storage.
  string,

  /// Uploads a file from the device.
  file,

  /// Clears any tasks from the list.
  clear,
}

class ItemProduto extends StatelessWidget {
  Produto produto;
  VoidCallback onTapItem;
  TextEditingController myController = TextEditingController();
  String quantidade;
  String nomeSelecionado;
  Pedidos _pedidos = Pedidos.gerarID();
  String loja;
  String status;
  bool statusPedido;
  Timestamp createdAt;
  File arquivo;

  ItemProduto({
    @required this.produto,
    this.onTapItem,
    this.myController,
    this.quantidade,
    this.nomeSelecionado,
    this.status,
    this.loja,
    this.createdAt,
    this.statusPedido,
    Pedidos pedido,
  });

  _showSnackbar(String message) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _enviarPedido() async {
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

    var now = new DateTime.now();
    String data = now.toString();

    Formulario formulario = Formulario(
        _pedidos.loja, _pedidos.nome, _pedidos.quantidade, "0", data);
    FormController formController = FormController((String response) {
      print("Response: $response");
      print(data);
      if (response == FormController.STATUS_SUCCESS) {
        //
        print(response);
      } else {
        print("erro");
      }
    });
    formController.submitForm(formulario);

    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("Meus Pedidos")
        .doc(loja)
        .collection("Pedidos")
        .doc(_pedidos.id)
        .set(_pedidos.toMap());
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

    db
        .collection("Pedidos" + _pedidos.loja)
        .doc(_pedidos.id)
        .set(_pedidos.toMap());

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
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: myController,
                    onChanged: (value) {
                      if (value == null) {
                        value = "0";
                      }
                      produto.quantidade = value;
                      nomeSelecionado = produto.nome;
                    },
                    decoration: InputDecoration(
                        hintText: "0",
                        contentPadding: EdgeInsets.fromLTRB(30, 5, 5, 5),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
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

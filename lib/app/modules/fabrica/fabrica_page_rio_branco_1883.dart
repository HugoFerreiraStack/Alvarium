import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/model/produto_model.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PedidosPageRioBranco1883 extends StatefulWidget {
  @override
  _PedidosPageRioBranco1883State createState() =>
      _PedidosPageRioBranco1883State();
}

class _PedidosPageRioBranco1883State extends State<PedidosPageRioBranco1883> {
  String idPedido;
  Pedidos _pedidos = Pedidos.gerarID();
  bool _pedidoAceito = false;
  TextEditingController myController = TextEditingController();

  _updateData(selectedDoc, newValue) {
    FirebaseFirestore.instance
        .collection("Meus Pedidos")
        .doc("Rio Branco - 1883")
        .collection("Pedidos")
        .doc(selectedDoc)
        .update(newValue)
        .catchError((e) {
      print(e);
    });
  }

  _deleteData(docId) {
    FirebaseFirestore.instance
        .collection("Meus Pedidos")
        .doc("Rio Branco - 1883")
        .collection("Pedidos")
        .doc(docId)
        .delete();
  }

  _deleteData2(docId) {
    FirebaseFirestore.instance
        .collection("PedidosRio Branco - 1883")
        .doc(docId)
        .delete();
  }

  _enviarPedidoNotification() async {
    //Salvar anuncio no Firestore
    Produto produto = Produto();
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    String idUsuario = usuarioLogado.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;

    _pedidos.quantidade = produto.quantidade;

    _pedidos.nome = produto.nome;
    _pedidos.loja = "";
    _pedidos.createdAt = Timestamp.now();
    _pedidos.status = "Enviado";
    _pedidos.statusPedido = true;

    _pedidos.toMap();

    db.collection("Pedidos Confirmados").doc(idUsuario).set(_pedidos.toMap());
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
        Navigator.pop(context);
      },
    );
    Widget editQtd = TextField(
      controller: myController,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value == null) {
          value = "0";
        }
        _pedidos.quantidade = value;
      },
      decoration: InputDecoration(
          hintText: "0",
          contentPadding: EdgeInsets.fromLTRB(30, 5, 5, 5),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmar Pedido"),
      content: Text("Tem certeza que deseja adicionar este item ao pedido?"),
      actions: [
        cancelButton,
        continueButton,
        editQtd,
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Pedidos Rio Branco - 1883",
            style: TextStyle(color: Palette.gold),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Meus Pedidos")
              .doc("Rio Branco - 1883")
              .collection("Pedidos")
              .orderBy("criado em", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LinearProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                padding: EdgeInsets.all(5),
                itemBuilder: (context, i) {
                  return new ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text(snapshot.data.docs[i].data()['nome']),
                    subtitle: Text(snapshot.data.docs[i].data()['quantidade']),
                    trailing: Checkbox(
                        onChanged: (bool value) {
                          _updateData(snapshot.data.docs[i].id,
                              {'status pedido': true});
                          if (snapshot.data.docs[i].data()['status pedido'] ==
                              true) {
                            _deleteData(snapshot.data.docs[i].id);
                            _deleteData2(snapshot.data.docs[i].id);
                          }
                        },
                        value: snapshot.data.docs[i].data()['status pedido']),
                    onTap: () {},
                  );
                },
              );
            }
          },
        ));
  }
}

import 'package:alvarium/app/shared/model/controller.dart';
import 'package:alvarium/app/shared/model/formulario.dart';
import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/model/updateFormulario.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PedidosPageHalfed extends StatefulWidget {
  @override
  _PedidosPageHalfedState createState() => _PedidosPageHalfedState();
}

class _PedidosPageHalfedState extends State<PedidosPageHalfed> {
  String idPedido;
  Pedidos _pedidos = Pedidos.gerarID();
  bool _pedidoAceito = false;
  TextEditingController myController = TextEditingController();
  String nomeProduto;

  _updateData(selectedDoc, newValue) {
    FirebaseFirestore.instance
        .collection("Meus Pedidos")
        .doc("Halfed - 811")
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
        .doc("Halfed - 811")
        .collection("Pedidos")
        .doc(docId)
        .delete();
  }

  _deleteData2(docId) {
    FirebaseFirestore.instance
        .collection("PedidosHalfed - 811")
        .doc(docId)
        .delete();
  }

  _enviarPedidoNotificationFab() async {
    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    String idUsuario = usuarioLogado.uid;

    _pedidos.quantidade = myController.text;

    _pedidos.nome = nomeProduto;
    _pedidos.loja = "";
    _pedidos.createdAt = Timestamp.now();
    _pedidos.status = "Enviado";
    _pedidos.statusPedido = true;

    _pedidos.toMap();

    FirebaseFirestore db = FirebaseFirestore.instance;

    db.collection("Pedidos enviados").doc(_pedidos.id).set(_pedidos.toMap());

    var now = new DateTime.now();
    String data = now.toString();

    Formulario formulario = Formulario(_pedidos.loja, _pedidos.nome,
        _pedidos.quantidade, myController.text, data);
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
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        _enviarPedidoNotificationFab();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alterar Quantidade?"),
      content: TextField(
        keyboardType: TextInputType.number,
        controller: myController,
        onChanged: (value) {
          if (value == null) {
            value = "0";
          }
          _pedidos.quantidade = value;
        },
        decoration: InputDecoration(
            hintText: "Digite a quantidade a ser enviada",
            contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Pedidos Halfeld",
            style: TextStyle(color: Palette.gold),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Meus Pedidos")
              .doc("Halfed - 811")
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
                    onTap: () {
                      nomeProduto = snapshot.data.docs[i].data()['nome'];
                      showAlertDialog(context);
                    },
                  );
                },
              );
            }
          },
        ));
  }
}

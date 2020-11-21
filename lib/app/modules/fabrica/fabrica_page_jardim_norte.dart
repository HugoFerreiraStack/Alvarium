import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PedidosPageJardimNorte extends StatefulWidget {
  @override
  _PedidosPageJardimNorteState createState() => _PedidosPageJardimNorteState();
}

class _PedidosPageJardimNorteState extends State<PedidosPageJardimNorte> {
  String idPedido;
  Pedidos _pedidos = Pedidos.gerarID();
  bool _pedidoAceito = false;

  _updateData(selectedDoc, newValue) {
    FirebaseFirestore.instance
        .collection("Meus Pedidos")
        .doc("Shopping Jardim Norte")
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
        .doc("Shopping Jardim Norte")
        .collection("Pedidos")
        .doc(docId)
        .delete();
  }

  _deleteData2(docId) {
    FirebaseFirestore.instance
        .collection("PedidosShopping Jardim Norte")
        .doc(docId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Pedidos Shopping Jardim Norte",
            style: TextStyle(color: Palette.gold),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Meus Pedidos")
              .doc("Shopping Jardim Norte")
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

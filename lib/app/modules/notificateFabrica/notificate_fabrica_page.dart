import 'package:alvarium/app/shared/custom_cliper.dart';
import 'package:alvarium/app/shared/model/controller.dart';
import 'package:alvarium/app/shared/model/formulario.dart';
import 'package:alvarium/app/shared/model/pedidos_model.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'notificate_fabrica_controller.dart';

class NotificateFabricaPage extends StatefulWidget {
  final String title;
  const NotificateFabricaPage({Key key, this.title = "NotificateFabrica"})
      : super(key: key);

  @override
  _NotificateFabricaPageState createState() => _NotificateFabricaPageState();
}

class _NotificateFabricaPageState
    extends ModularState<NotificateFabricaPage, NotificateFabricaController>
    with SingleTickerProviderStateMixin {
  //use 'controller' variable to access controller

  Animation<double> _animation;
  AnimationController _animationController;
  int index;
  Pedidos _pedidos = Pedidos.gerarID();
  String quantidade;
  String nomeProduto;
  String loja;

  _updateData(docId, newValue) {
    FirebaseFirestore.instance
        .collection("Pedidos")
        .doc(docId)
        .update(newValue)
        .catchError((e) {
      print(e);
    });
  }

  _enviarPedidoConfirmado() async {
    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    String idUsuario = usuarioLogado.uid;

    _pedidos.quantidade = quantidade;

    _pedidos.nome = nomeProduto;
    _pedidos.loja = loja;
    _pedidos.createdAt = Timestamp.now();
    _pedidos.status = "Enviado";
    _pedidos.statusPedido = true;

    _pedidos.toMap();

    FirebaseFirestore db = FirebaseFirestore.instance;

    db
        .collection("Pedidos Notificados Fabrica")
        .doc(_pedidos.id)
        .set(_pedidos.toMap());

    var now = new DateTime.now();
    String data = now.toString();

    Formulario formulario =
        Formulario(_pedidos.loja, _pedidos.nome, "", quantidade, data);
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

  _deleteData(docId) {
    FirebaseFirestore.instance.collection("Pedidos").doc(docId).delete();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
            leading: Image.asset(
              "images/logo.png",
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
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Pedidos enviados")
            .orderBy("criado em", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return new ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapShot) {
              return Dismissible(
                key: ObjectKey(documentSnapShot.data().keys),
                onDismissed: (direction) {
                  nomeProduto = documentSnapShot.data()['nome'];
                  loja = "Fabrica";
                  quantidade = documentSnapShot.data()['quantidade'];

                  documentSnapShot.data().remove(index);
                  _enviarPedidoConfirmado();
                  _deleteData(documentSnapShot.id);
                },
                direction: DismissDirection.startToEnd,
                child: Card(
                  child: ListTile(
                    tileColor: Palette.black,
                    subtitle: Text(
                      documentSnapShot.data()['quantidade'],
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      (Icons.fastfood),
                      color: Palette.gold2,
                    ),
                    title: Text(
                      documentSnapShot.data()['nome'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Palette.gold2),
                    ),
                  ),
                ),
              );
            }).toList());
          }
        },
      ),

      //Init Floating Action Bubble
    );
  }
}

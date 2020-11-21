import 'package:alvarium/app/shared/custom_cliper.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  String lojaUsuario = "";

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

  @override
  void initState() {
    _verificarUsuarioLogado(lojaUsuario);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
            title: Text(
              lojaUsuario,
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
      body: PaginateFirestore(
        //item builder type is compulsory.
        itemBuilderType:
            PaginateBuilderType.listView, //Change types accordingly
        itemBuilder: (index, context, documentSnapshot) => ListTile(
          leading: CircleAvatar(child: Icon(Icons.fastfood)),
          title: Text(documentSnapshot.data()['nome']),
          subtitle: Text(documentSnapshot.data()['quantidade']),
        ),
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance
            .collection('Meus Pedidos')
            .doc(_verificarUsuarioLogado(lojaUsuario).toString())
            .collection('Pedidos')
            .orderBy('criado em', descending: false),
      ),
    );
  }
}

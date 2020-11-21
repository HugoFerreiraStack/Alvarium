import 'package:alvarium/app/modules/fabrica/fabrica_page_av_sete.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_halfed.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_ind_shop.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_jardim_norte.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_marechal_384.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_marechal_534.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_mister_moore.dart';
import 'package:alvarium/app/modules/fabrica/fabrica_page_rio_branco_1883.dart';
import 'package:alvarium/app/shared/custom_cliper.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'fabrica_controller.dart';

class FabricaPage extends StatefulWidget {
  final String title;

  const FabricaPage({Key key, this.title = "Fabrica"}) : super(key: key);

  @override
  _FabricaPageState createState() => _FabricaPageState();
}

class _FabricaPageState extends ModularState<FabricaPage, FabricaController>
    with SingleTickerProviderStateMixin {
  //use 'controller' variable to access controller
  Animation<double> _animation;
  AnimationController _animationController;
  int index;
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

  _deleteData(docId) {
    FirebaseFirestore.instance.collection("Pedidos").doc(docId).delete();
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
              .collection("Pedidos")
              .orderBy("criado em", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return new ListView(
                  children: snapshot.data.docs
                      .map((DocumentSnapshot documentSnapShot) {
                return Dismissible(
                  key: ObjectKey(documentSnapShot.data().keys),
                  onDismissed: (direction) {
                    documentSnapShot.data().remove(index);
                    _deleteData(documentSnapShot.id);
                  },
                  direction: DismissDirection.startToEnd,
                  child: Card(
                    child: ListTile(
                      tileColor: Palette.black,
                      subtitle: Text(
                        documentSnapShot.data()['loja'],
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        //Init Floating Action Bubble
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            Bubble(
              title: "Halfeld - 811",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                _animationController.reverse();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosPageHalfed()));
                _animationController.reverse();
              },
            ),
            // Floating action menu item

            Bubble(
              title: "Marechal - 384",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosPageMarechal384()));
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Marechal - 534",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosPageMarechal534()));
                _animationController.reverse();
              },
            ),

            Bubble(
              title: "Mister Moore - 09",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosPageMisterMoore()));
                _animationController.reverse();
              },
            ),

            Bubble(
              title: "Rio Branco - 1883",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosPageRioBranco1883()));
                _animationController.reverse();
              },
            ),

            //Floating action menu item
            Bubble(
              title: "Shopping Indepencia",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosIndSHopdPage()));
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Av. Sete de Setembro",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosPageAvSete()));
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Shopping Jardim Norte",
              iconColor: Palette.black,
              bubbleColor: Palette.gold2,
              icon: Icons.store,
              titleStyle: TextStyle(fontSize: 16, color: Palette.black),
              onPress: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PedidosPageJardimNorte()));
                _animationController.reverse();
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Palette.gold2,

          // Flaoting Action button Icon
          iconData: Icons.shopping_cart,
          backGroundColor: Palette.black,
        ));
  }
}

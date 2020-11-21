import 'package:alvarium/app/shared/palett.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'selection_controller.dart';

class SelectionPage extends StatefulWidget {
  final String title;
  const SelectionPage({Key key, this.title = "Selection"}) : super(key: key);

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState
    extends ModularState<SelectionPage, SelectionController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
      body: Container(
        padding: EdgeInsets.all(26),
        alignment: Alignment.topCenter,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    'images/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Selecione como deseja Logar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Modular.to.pushReplacementNamed('/login');
                      },
                      child: Text(
                        "Logar como Loja",
                        style: TextStyle(color: Palette.black, fontSize: 15),
                      ),
                      color: Palette.gold,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Modular.to.pushReplacementNamed('/login_fabrica');
                      },
                      child: Text(
                        "Logar como CD",
                        style: TextStyle(color: Palette.black, fontSize: 15),
                      ),
                      color: Palette.gold,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    Modular.to.pushReplacementNamed('/login_not_fab');
                  },
                  child: Text(
                    "Logar como Fabrica",
                    style: TextStyle(color: Palette.black, fontSize: 15),
                  ),
                  color: Palette.gold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'lojas_controller.dart';

class LojasPage extends StatefulWidget {
  final String title;
  const LojasPage({Key key, this.title = "Lojas"}) : super(key: key);

  @override
  _LojasPageState createState() => _LojasPageState();
}

class _LojasPageState extends ModularState<LojasPage, LojasController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}

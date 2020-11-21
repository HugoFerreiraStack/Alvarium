import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    ));
  }
}

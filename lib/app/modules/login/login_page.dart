import 'package:alvarium/app/modules/login/background_painter.dart';
import 'package:alvarium/app/modules/login/register.dart';
import 'package:alvarium/app/modules/login/sign_in.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);
  //use 'controller' variable to access controller

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _redirecionaPainelPorLoja(String idUsuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.currentUser.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("Usuarios").doc(auth.toString()).get();

    Map<String, dynamic> dados = snapshot.data();
    String lojaUsuario = dados["loja"];

    /*
    switch (lojaUsuario) {
      case "Halfed - 811":
        Modular.to.pushReplacementNamed('start');
        break;
      case "Shopping Indepencia":
        Modular.to.pushReplacementNamed('/start_rio_branco');
        break;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LitAuth.custom(
        errorNotification: const NotificationConfig(
          backgroundColor: Palette.black,
          icon: Icon(
            Icons.error_outline,
            color: Palette.brown,
            size: 32,
          ),
        ),
        onAuthSuccess: () {
          FirebaseAuth auth = FirebaseAuth.instance;
          auth.currentUser.uid;
          String idUsuario = auth.toString();

          Modular.to.pushReplacementNamed('/start');
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _controller,
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ValueListenableBuilder<bool>(
                  valueListenable: showSignInPage,
                  builder: (context, value, child) {
                    return SizedBox.expand(
                      child: PageTransitionSwitcher(
                        reverse: !value,
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder:
                            (child, animation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            fillColor: Colors.transparent,
                            child: child,
                          );
                        },
                        child: value
                            ? SignIn(
                                key: const ValueKey('SignIn'),
                                onRegisterClicked: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = false;
                                  _controller.forward();
                                },
                              )
                            : Register(
                                key: const ValueKey('Register'),
                                onSignInPressed: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = true;
                                  _controller.reverse();
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

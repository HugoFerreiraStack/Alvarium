import 'package:alvarium/app/shared/custom_cliper.dart';
import 'package:alvarium/app/shared/model/usuario.dart';
import 'package:alvarium/app/shared/palett.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'usuarios_controller.dart';

class UsuariosPage extends StatefulWidget {
  final String title;
  const UsuariosPage({Key key, this.title = "Usuarios"}) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class Loja {
  int id;
  String nomeLoja;

  Loja(this.id, this.nomeLoja);

  static List<Loja> getLojas() {
    return <Loja>[
      Loja(1, "Halfed - 811"),
      Loja(2, "Rio Branco - 1883"),
      Loja(3, "Shopping Indepencia"),
      Loja(4, "Shopping Jardim Norte"),
      Loja(5, "Marechal - 384"),
      Loja(6, "Marechal - 534"),
      Loja(7, "Mister Moore - 09"),
      Loja(8, "Av. Sete de Setembro")
    ];
  }
}

class _UsuariosPageState
    extends ModularState<UsuariosPage, UsuariosController> {
  //use 'controller' variable to access controller

  List<Loja> _lojas = Loja.getLojas();
  List<DropdownMenuItem<Loja>> _dropDownMenuItems;
  Loja _lojaSelecionada;

  String _mensagemErro = "";

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  @override
  void initState() {
    _dropDownMenuItems = builDropDownMenuItems(_lojas);
    _lojaSelecionada = _dropDownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<Loja>> builDropDownMenuItems(List lojas) {
    List<DropdownMenuItem<Loja>> items = List();
    for (Loja loja in lojas) {
      items.add(
        DropdownMenuItem(
          value: loja,
          child: Text(loja.nomeLoja),
        ),
      );
    }
    return items;
  }

  onChangeDropDownItem(Loja lojaSelecionada) {
    setState(() {
      _lojaSelecionada = lojaSelecionada;
    });
  }

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 5) {
      } else {
        setState(() {
          _mensagemErro = "Sua senha deve ter no minimo 6 caracteres";
        });
      }
      Usuario usuario = Usuario();
      usuario.email = email;
      usuario.senha = senha;
      usuario.loja = _lojaSelecionada.nomeLoja;
      _cadastrarUsuario(usuario);
    } else {
      setState(() {
        _mensagemErro = "Preencha um E-mail Válido";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      setState(() {
        FirebaseFirestore db = FirebaseFirestore.instance;
        db
            .collection("Usuarios")
            .doc(firebaseUser.user.uid)
            .set(usuario.toMap());

        _mensagemErro = "Usuario Cadastrado com Sucesso";
      });
    }).catchError((onError) {
      _mensagemErro =
          "Erro ao cadastrar Usuario, verifique os campos e tente novamente!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
            title: Text(
              "Cadastro de Usuários",
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Selecione a Loja"),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: _lojaSelecionada,
                  items: _dropDownMenuItems,
                  onChanged: onChangeDropDownItem,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text(
                    "CADASTRAR",
                    style: TextStyle(color: Palette.gold, fontSize: 20),
                  ),
                  color: Palette.black,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: () {
                    print(_lojaSelecionada.nomeLoja);
                    _validarCampos();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(_mensagemErro)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

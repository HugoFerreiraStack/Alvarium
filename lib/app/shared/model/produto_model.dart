import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String _id;
  String _codigo;
  String _nome;
  String _grupoProduto;
  String _status;
  bool _statusPedido;
  String _quantidade;

  Produto();
  Produto.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.nome = documentSnapshot['nome'];
    this.status = documentSnapshot['status'];
    this.statusPedido = documentSnapshot['status pedido'];
    this._grupoProduto = documentSnapshot['grupo de produtos'];
  }

  Produto.gerarID() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference produtos = db.collection("Produtos");
    this.id = produtos.doc().id;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "codigo": this.codigo,
      "nome": this.nome,
      "grupo de produtos": this.grupoProduto,
      "status": this.status,
      "status pedido": this.statusPedido,
      "quantidade": this.quantidade,
    };
    return map;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  bool get statusPedido => _statusPedido;

  set statusPedido(bool value) {
    _statusPedido = value;
  }

  String get codigo => _codigo;

  set codigo(String value) {
    _codigo = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get grupoProduto => _grupoProduto;

  set grupoProduto(String value) {
    _grupoProduto = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get quantidade => _quantidade;

  set quantidade(String value) {
    _quantidade = value;
  }
}

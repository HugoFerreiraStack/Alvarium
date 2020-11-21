import 'package:alvarium/app/shared/model/item_produto.dart';
import 'package:alvarium/app/shared/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pedidos {
  String _id;
  String _nome;
  String _loja;
  String _quantidade;
  String _status;
  bool _statusPedido;
  Timestamp createdAt;

  Pedidos.fromItem(ItemProduto itemProduto, DocumentSnapshot documentSnapshot) {
    this.nome = itemProduto.produto.nome;
    this.quantidade = itemProduto.produto.quantidade;
    this.id = documentSnapshot.id;
    this.loja = Usuario().loja.toString();
    this.status = itemProduto.status;
    this._statusPedido = itemProduto.statusPedido;
    this.createdAt = itemProduto.createdAt;
  }

  Pedidos();
  Pedidos.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.nome = documentSnapshot["nome"];
    this.quantidade = documentSnapshot['quantidade'];
    this.id = documentSnapshot.id;
    this.loja = Usuario().loja.toString();
    this.status = documentSnapshot['status'];
    this._statusPedido = documentSnapshot['status pedido'];
    this.createdAt = documentSnapshot['criado em'];
  }

  Pedidos.gerarID() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference pedidos = db.collection("Pedidos");
    this.id = pedidos.doc().id;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "nome": this.nome,
      "loja": this.loja,
      "quantidade": this.quantidade,
      "status": this.status,
      "status pedido": this.statusPedido,
      "criado em": this.createdAt,
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

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get quantidade => _quantidade;

  set quantidade(String value) {
    _quantidade = value;
  }

  String get loja => _loja;

  set loja(String value) {
    _loja = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }
}

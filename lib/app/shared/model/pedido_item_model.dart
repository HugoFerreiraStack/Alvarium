import 'package:alvarium/app/shared/model/produto_model.dart';

class PedidoItemModel {
  Produto produto;
  String quantidade;
  String loja;
  bool statusPedido;

  PedidoItemModel(
      {this.produto, this.quantidade, this.loja, this.statusPedido});

  Map<String, dynamic> toMap() {
    return {
      'produto': produto?.toMap(),
      'quantidade': quantidade,
      'loja': loja,
      'status pedido': statusPedido,
    };
  }
}

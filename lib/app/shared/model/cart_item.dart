import 'package:alvarium/app/shared/model/produto_model.dart';

class CartItem {
  String itemNome;
  String itemQuatidade;

  CartItem({
    this.itemNome,
    this.itemQuatidade,
  });
}

List<CartItem> cartItem = [];

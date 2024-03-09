import 'package:lab_app/src/model/item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;

  CartItemModel({
    required this.item,
    required this.quantity,
  });

  double totalPrice() {
    return quantity * item.price;
  }
}

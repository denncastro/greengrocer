import 'package:lab_app/src/model/cart_item_model.dart';

class OrderModel {
  String id;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  String copyAndPaste;
  String status;
  double total;
  List<CartItemModel> items;

  OrderModel({
    required this.copyAndPaste,
    required this.overdueDateTime,
    required this.createdDateTime,
    required this.status,
    required this.total,
    required this.id,
    required this.items,
  });
}

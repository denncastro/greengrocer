import 'package:flutter/material.dart';
import 'package:lab_app/src/page/commom_widgets/custom_quantity_widget.dart';
import 'package:lab_app/src/model/cart_item_model.dart';
import 'package:lab_app/src/services/utils_services.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.cartItemModel,
    required this.remove,
  });

  final CartItemModel cartItemModel;
  final Function(CartItemModel) remove;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ListTile(
          leading: SizedBox(
            height: 60,
            width: 60,
            child: Image.asset(
              widget.cartItemModel.item.imageUrl,
            ),
          ),
          title: Text(
            widget.cartItemModel.item.itemName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            utilsServices.priceToCurrency(widget.cartItemModel.totalPrice()),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          trailing: QuantityWidget(
            value: widget.cartItemModel.quantity,
            unit: widget.cartItemModel.item.unit,
            isRemovable: true,
            result: (quantity) {
              setState(() {
                widget.cartItemModel.quantity = quantity;

                if (quantity == 0) {
                  widget.remove(widget.cartItemModel);
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

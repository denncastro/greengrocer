import 'package:flutter/material.dart';
import 'package:lab_app/src/page/commom_widgets/payment_dialog.dart';
import 'package:lab_app/src/model/order_model.dart';
import 'package:lab_app/src/page/order/components/order_status_widget.dart';
import 'package:lab_app/src/services/utils_services.dart';
import '../../../model/cart_item_model.dart';

class OrderTile extends StatelessWidget {
  OrderTile({
    super.key,
    required this.order,
  });

  final OrderModel order;

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: order.status == "pending_payment",
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            "Pedidos: ${order.id}",
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          subtitle: Text(
            order.createdDateTime.toString(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        children: order.items.map((orderItem) {
                          return _OrderItemWidget(
                            utilsServices: utilsServices,
                            order: orderItem,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: OrderStatusWidget(
                      status: order.status,
                      isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                    ),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(
                    text: "Total: ",
                  ),
                  TextSpan(
                    text: utilsServices.priceToCurrency(order.total),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: order.status == "pending_payment",
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return PaymentDialog(order: order);
                        });
                  },
                  icon: Image.asset(
                    "assets/app_images/pix.png",
                    height: 25,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  label: const Text(
                    "Ver QR Código Pix",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    required this.utilsServices,
    required this.order,
  });

  final UtilsServices utilsServices;
  final CartItemModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${order.quantity} ${order.item.unit} ",
        ),
        Expanded(
          child: Text(
            order.item.itemName,
          ),
        ),
        Text(
          utilsServices.priceToCurrency(
            order.item.price,
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

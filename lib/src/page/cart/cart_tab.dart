import 'package:flutter/material.dart';
import 'package:lab_app/src/page/commom_widgets/payment_dialog.dart';
import 'package:lab_app/src/model/cart_item_model.dart';
import 'package:lab_app/src/page/cart/components/cart_item.dart';
import 'package:lab_app/src/services/utils_services.dart';
import 'package:lab_app/src/config/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItem.remove(cartItem);

      utilsServices.showToast(
        label: "Pedido Eliminado",
      );
    });
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in app_data.cartItem) {
      total += item.totalPrice();
    }
    return total;
  }

  Future<bool?> orderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Confirmação"),
          content: const Text("Deseja realmente concluir o pedido?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Não"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(100),
      appBar: AppBar(
        title: const Text(
          "Carrinho",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: app_data.cartItem.length,
              itemBuilder: (context, index) {
                return CartItem(
                  cartItemModel: app_data.cartItem[index],
                  remove: removeItemFromCart,
                );
              },
            ),
          ),
          SizedBox(
            height: 150,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Total Geral",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    utilsServices.priceToCurrency(cartTotalPrice()),
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool? result = await orderConfirmation();

                        if (context.mounted && (result ?? false)) {
                          showDialog(
                            context: context,
                            builder: (builder) {
                              return PaymentDialog(
                                order: app_data.orders.first,
                              );
                            },
                          );
                        } else {
                          utilsServices.showToast(
                            label: "Pedido Cancelado",
                            isError: true,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "Concluir Pedido",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

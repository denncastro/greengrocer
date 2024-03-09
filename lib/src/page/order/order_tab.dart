import 'package:flutter/material.dart';
import 'package:lab_app/src/config/app_data.dart' as app_data;
import 'package:lab_app/src/page/order/components/order_tile.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(10),
      appBar: AppBar(
        title: const Text(
          "Pedidos",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return OrderTile(
            order: app_data.orders[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: app_data.orders.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lab_app/src/model/order_model.dart';
import 'package:lab_app/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({
    super.key,
    required this.order,
  });

  final UtilsServices utilsServices = UtilsServices();
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Pagamento com Pix",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                QrImageView(
                  data: "fkmfdklbmd" * 10,
                  version: QrVersions.auto,
                  size: 200,
                ),
                Text(
                  "Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}",
                ),
                Text(
                  "Total: ${utilsServices.priceToCurrency(order.total)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    utilsServices.showToast(
                      label: "Código Pix Copiado",
                    );
                  },
                  icon: const Icon(Icons.copy_outlined),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  label: const Text("Copiar Código Pix"),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}

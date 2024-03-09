import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  OrderStatusWidget({
    super.key,
    required this.status,
    required this.isOverdue,
  });

  final String status;
  final bool isOverdue;

  final Map<String, int> allStatus = <String, int>{
    "pending_payment": 0,
    "refund": 1,
    "paid": 2,
    "preparing_purchase": 3,
    "shipping": 4,
    "delivered": 5,
  };

  int get currentStatus => allStatus[status]!;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusDot(
          isActive: true,
          title: "Pagamento confirmado",
        ),
        const DotDivider(),
        if (currentStatus == 1) ...[
          const StatusDot(
            isActive: true,
            title: "Pix Estornado",
            backgroundColor: Colors.orange,
            borderColor: Colors.transparent,
          ),
        ] else if (isOverdue) ...[
          const StatusDot(
            isActive: true,
            title: "Pagamento Cancelado",
            backgroundColor: Colors.red,
            borderColor: Colors.transparent,
          )
        ] else ...[
          const StatusDot(
            isActive: false,
            title: "Pagamento",
          ),
          const DotDivider(),
          const StatusDot(
            isActive: false,
            title: "Preparando",
          ),
          const DotDivider(),
          const StatusDot(
            isActive: false,
            title: "Envio",
          ),
          const DotDivider(),
          const StatusDot(
            isActive: false,
            title: "Entregue",
          ),
        ]
      ],
    );
  }
}

class DotDivider extends StatelessWidget {
  const DotDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class StatusDot extends StatelessWidget {
  const StatusDot({
    super.key,
    required this.isActive,
    required this.title,
    this.backgroundColor,
    this.borderColor,
  });

  final bool isActive;
  final String title;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isActive ? backgroundColor ?? Colors.green : Colors.transparent,
            border: Border.all(color: borderColor ?? Colors.green),
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 5),
        Expanded(child: Text(title)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/custom_colors.dart';

class CustomHeadlineText extends StatelessWidget {
  const CustomHeadlineText({super.key, this.textSize = 40, this.color});

  final double textSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: "Green",
            style: TextStyle(
              color: color ?? Colors.green,
            ),
          ),
          TextSpan(
            text: "grocer",
            style: TextStyle(
              color: CustomColors.customSwatchColor,
            ),
          ),
        ],
      ),
    );
  }
}

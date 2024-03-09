import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.height,
    required this.width,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
    this.isRounded = false,
  });

  final double height;
  final double width;
  final Color? baseColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;
  final bool isRounded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade800,
        highlightColor: highlightColor ?? Colors.grey.shade500,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: borderRadius ??
                BorderRadius.circular(isRounded ? height / 2 : 0),
          ),
        ),
      ),
    );
  }
}

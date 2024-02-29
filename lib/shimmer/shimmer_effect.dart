


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({
  required this.height,
  required this.width,
  super.key});
  final double? height;
  final double? width;

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(5),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Colors.grey,
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}

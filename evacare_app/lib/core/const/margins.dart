import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {
  final double x;
  const XMargin({super.key, required this.x});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: x,
    );
  }
}

class YMargin extends StatelessWidget {
  final double y;
  const YMargin({super.key, required this.y});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: y,
    );
  }
}

extension CustomContext on BuildContext {
  double screenWidth([double percent = 1]) => MediaQuery.of(this).size.width *percent;
  double screenHeight ([double percent = 1]) => MediaQuery.of(this).size.height *percent;
}
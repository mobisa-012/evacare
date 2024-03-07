import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 18
        ),
      ),
    );
  }
}
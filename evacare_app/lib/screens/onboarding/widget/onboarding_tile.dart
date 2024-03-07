// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:evacare_app/core/const/margins.dart';
import 'package:flutter/material.dart';

class OnboardingTile extends StatelessWidget {
  final title, image, description;
  const OnboardingTile({super.key, this.title, this.image, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const YMargin(y: 50),
       Image.asset(image),
       Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700
        ),
       ) ,
       Text(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16
        ),
       )
      ],
    );
  }
}
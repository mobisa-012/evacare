import 'package:evacare_app/core/const/margins.dart';
import 'package:evacare_app/core/const/path_const.dart';
import 'package:flutter/material.dart';

class ChatGptAnswerWidget extends StatelessWidget {
  final String answer;
  const ChatGptAnswerWidget({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: SizedBox(
            height: 32,
            width: 32,
            child: Image.asset(PathConstants.gpt),
          ),
        ),
        const XMargin(x: 32),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Text(
              answer.toString().trim(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        )
      ],
    );
  }
}
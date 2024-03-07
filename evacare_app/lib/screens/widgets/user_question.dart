import 'package:flutter/material.dart';

class UserQuestionWidget extends StatelessWidget {
  final String question;

  const UserQuestionWidget({required this.question, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              color:Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              question,
              style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const ClipOval(
          child: Material(
            color: Colors.deepOrangeAccent,
            child: SizedBox(
              height: 32,
              width: 32,
              child: Center(
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
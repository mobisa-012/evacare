import 'package:evacare_app/core/const/margins.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSubmitted;
  const TextInputWidget({super.key, required this.textController, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.only(bottom: 12, left: 12),
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
                bottom: Radius.circular(12)
              )
            ),
            child: TextFormField(
              controller: textController,
              minLines: 1,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontSize: 16
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Ask your question....',
                hintStyle: TextStyle(
                  fontSize: 16
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 12),
              ),
              onFieldSubmitted: (_) => onSubmitted,
            ),
          )
        ),
        const XMargin(x: 12),
        Container(
          width: 48,
          height: 48,
          margin: const EdgeInsets.only(bottom: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.lightBlue[300]
          ),
          child: GestureDetector(
            onTap: onSubmitted,
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
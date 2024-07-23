import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectCard extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;

  const SelectCard({super.key, required this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                content,
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
          indent: 1,
          endIndent: 10,
          height: 0.5,
        ),
      ],
    );
  }
}

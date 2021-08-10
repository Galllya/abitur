import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final String label;

  final String value;
  const Separator({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF909090),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

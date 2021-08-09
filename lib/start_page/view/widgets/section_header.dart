import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onButtonTap;
  const SectionHeader({
    Key? key,
    required this.buttonText,
    required this.title,
    required this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              onButtonTap();
            },
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.red.shade900,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

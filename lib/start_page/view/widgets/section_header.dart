
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
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// Тут я не заметил раньше, но лучше выносить обработчик onTap в аргументы виджета,
          /// чтобы не было таких условий(например, если мы добавим еще третий раздел и так далее) и было что-то вроде
          /// как я указал в комментариях тут и выше
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

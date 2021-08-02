import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  /// Тут лучше именовать не исходя из визуала "буквально", а исходя из смыслового содержания
  /// Верхний текст - это подпись(иначе label) для основного текста, который является "значением" выводимого поля,
  ///  т.е. образуется связка "подпись для значения" - "label - value",
  /// littleText - label
  final String label;

  /// bigText - value
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
          style: TextStyle(
            fontSize: 14,
            color: Color(0XFF909090),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

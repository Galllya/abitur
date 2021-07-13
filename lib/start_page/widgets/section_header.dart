import 'package:abitur/event_page/event.dart';
import 'package:abitur/models/list_screen.dart';
import 'package:abitur/news_page/news.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  const SectionHeader({
    Key? key,
    required this.buttonText,
    required this.title,
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
          InkWell(
            onTap: () {
              title == 'Новости'
                  ? Navigator.push(
                      context, MaterialPageRoute(builder: (context) => News()))
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Event()));
            },
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.red.shade900,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

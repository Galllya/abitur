import 'package:abitur/domain/news.dart';
import 'package:abitur/one_news_page/view/one_news_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class NewsSectionCard extends StatelessWidget {
  final NewsArticle _newsViewModel;

  const NewsSectionCard({Key? key, required NewsArticle newsViewModel})
      : _newsViewModel = newsViewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OneNewsPage(id: _newsViewModel.id.toInt())));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _newsViewModel.title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            height: 22 / 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset('assets/icons/icon_calendar.svg',
                          height: 10, width: 10),
                    ),
                    Text(
                      DateFormat.yMd('ru_RU').format(_newsViewModel.date),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 18 / 14,
                          color: Color(0xFF909090)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

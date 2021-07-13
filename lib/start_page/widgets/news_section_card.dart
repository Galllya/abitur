import 'package:abitur/models/news_model.dart';
import 'package:abitur/one_news_page/one_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class NewsSectionCard extends StatelessWidget {
  final NewsViewModel _newsViewModel;

  const NewsSectionCard({Key? key, required NewsViewModel newsViewModel})
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
            offset: Offset(0, 2),
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
                        OneNews(newsViewModel: _newsViewModel)));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _newsViewModel.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            height: 22 / 16),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: SvgPicture.asset('assets/icons/icon_calendar.svg',
                          height: 10, width: 10),
                    ),
                    Text(
                      DateFormat.yMd('ru_RU').format(_newsViewModel.date),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 18 / 14,
                          color: Color(0XFF909090)),
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

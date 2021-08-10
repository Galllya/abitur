import 'package:abitur/domain/event.dart';
import 'package:abitur/one_event_page/view/one_event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EventSectionCard extends StatelessWidget {
  final EventArticle _eventViewModel;

  const EventSectionCard({Key? key, required EventArticle eventViewModel})
      : _eventViewModel = eventViewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    String? eventTime;
    if (_eventViewModel.dateFrom != null) {
      if (_eventViewModel.dateFrom!.difference(now).inDays < 0) {
      } else {
        eventTime =
            'Через ${_eventViewModel.dateFrom!.difference(now).inDays ~/ 30} месяцев';
      }
    }

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
                        OneEventPage(id: _eventViewModel.id.toInt())));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              children: [
                if (eventTime != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Text(
                          eventTime,
                          style: TextStyle(
                            fontSize: 14,
                            height: 18 / 14,
                            color: Colors.red.shade900,
                          ),
                        )
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Column(children: [
                        Text(
                          _eventViewModel.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 22 / 16),
                        ),
                      ]),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                if (_eventViewModel.dateFrom != null)
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                            'assets/icons/icon_calendar.svg',
                            height: 10,
                            width: 10),
                      ),
                      Text(
                        DateFormat.yMd('ru_RU')
                                .format(_eventViewModel.dateFrom!) +
                            ' - ' +
                            DateFormat.yMd('ru_RU')
                                .format(_eventViewModel.dateTo!),
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

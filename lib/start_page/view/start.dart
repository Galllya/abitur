import 'package:abitur/common/widgets/event_section_card.dart';
import 'package:abitur/common/widgets/news_section_card.dart';
import 'package:abitur/event_page/view/event_page.dart';
import 'package:abitur/news_page/view/news_page.dart';
import 'package:abitur/start_page/bloc/start_bloc.dart';
import 'package:abitur/start_page/view/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartListState createState() => _StartListState();
}

class _StartListState extends State<Start> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartBloc, StartState>(
        builder: (BuildContext context, StartState state) {
      if (state.loading) {
        return Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [CircularProgressIndicator()]),
        );
      } else {
        return ListView(
          children: [
            SectionHeader(
                buttonText: 'Все новости',
                title: 'Новости',
                onButtonTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewsPage()));
                }),
            if (state.news != null)
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
                  child: Column(
                    children: List.generate(
                      state.news!.length,
                      (index) => Padding(
                          padding: EdgeInsets.only(
                              bottom: index == state.news!.length - 1 ? 0 : 8),
                          child: NewsSectionCard(
                            newsViewModel: state.news!.elementAt(index),
                          )),
                    ),
                  ))
            else
              Center(
                child: Text(
                  'Ошибка при загрузке новостей',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            SectionHeader(
              buttonText: 'Все события',
              title: 'События',
              onButtonTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventPage()));
              },
            ),
            if (state.event != null)
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
                  child: Column(
                    children: List.generate(
                      state.event!.length,
                      (index) => Padding(
                          padding: EdgeInsets.only(
                              bottom: index == state.event!.length - 1 ? 0 : 8),
                          child: EventSectionCard(
                            eventViewModel: state.event!.elementAt(index),
                          )),
                    ),
                  ))
            else
              Center(
                child: Text(
                  'Ошибка при загрузке событий',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              )
          ],
        );
      }
    });
  }
}

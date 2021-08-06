import 'package:abitur/common/widgets/event_section_card.dart';
import 'package:abitur/event_page/bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<Event> {
  int number = 0;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
        builder: (BuildContext context, EventState state) {
      if (state.loading && state.news.isEmpty)
        return Center(child: CircularProgressIndicator());
      if (state.news.isEmpty) {
        return Center(child: Text('Нет новостей'));
      } else {
        return Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              ...state.news.map((eventArticle) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: EventSectionCard(
                    eventViewModel: eventArticle,
                  ))),
            ],
          ),
        );
      }
    });
  }
}

import 'package:abitur/data/event_repository.dart';
import 'package:abitur/event_page/bloc/event_bloc.dart';
import 'package:abitur/event_page/view/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventPage> {
  late EventBloc eventBloc;

  @override
  void initState() {
    super.initState();
    eventBloc = EventBloc(
      eventRepository: context.read<EventRepository>(),
    )..add(EventLoaded(page: 1));
  }

  @override
  void dispose() {
    eventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: eventBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Мероприятия'),
          centerTitle: true,
        ),
        body: const Event(),
      ),
    );
  }
}

import 'package:abitur/common/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:abitur/data/event_repository.dart';
import 'package:abitur/one_event_page/bloc/one_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'one_event.dart';

class OneEventPage extends StatefulWidget {
  final int _id;
  const OneEventPage({Key? key, required int id})
      : _id = id,
        super(key: key);

  @override
  _OneEventListPageState createState() => _OneEventListPageState();
}

class _OneEventListPageState extends State<OneEventPage> {
  late OneEventBloc oneEventBloc;

  @override
  void initState() {
    super.initState();
    oneEventBloc = OneEventBloc(
      favoritesBloc: context.read<FavoritesBloc>(),
      eventRepository: context.read<EventRepository>(),
    )..add(OneEventLoaded(id: widget._id));
  }

  @override
  void dispose() {
    oneEventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: oneEventBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Мероприятие'),
          centerTitle: true,
        ),
        body: const OneEvent(),
      ),
    );
  }
}

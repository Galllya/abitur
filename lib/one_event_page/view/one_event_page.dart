import 'package:abitur/data/event_provider.dart';
import 'package:abitur/data/event_repository.dart';
import 'package:abitur/one_event_page/bloc/one_event_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'one_event.dart';

class OneEventPage extends StatefulWidget {
  final int _id;
  const OneEventPage({Key? key, required int id}) : _id = id;

  @override
  _OneEventListPageState createState() => _OneEventListPageState();
}

class _OneEventListPageState extends State<OneEventPage> {
  late OneEventBloc oneEventBloc;

  @override
  void initState() {
    super.initState();
    oneEventBloc = OneEventBloc(
      EventRepository: EventRepository(EventProvider(Dio(BaseOptions(
          connectTimeout: 2000, receiveTimeout: 2000, sendTimeout: 2000)))),
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
          title: Text('Мероприятие'),
          centerTitle: true,
        ),
        body: OneEvent(),
      ),
    );
  }
}

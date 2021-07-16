import 'package:abitur/data/event_provider.dart';
import 'package:abitur/data/event_repository.dart';
import 'package:abitur/data/news_provider.dart';
import 'package:abitur/data/news_repository.dart';
import 'package:abitur/start_page/bloc/start_bloc.dart';
import 'package:abitur/start_page/view/start.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartListPageState createState() => _StartListPageState();
}

class _StartListPageState extends State<StartPage> {
  late StartBloc startBloc;

  @override
  void initState() {
    super.initState();
    startBloc = StartBloc(
        newsRepository: NewsRepository(NewsProvider(Dio(BaseOptions(
            connectTimeout: 2000, receiveTimeout: 2000, sendTimeout: 2000)))),
        eventRepository: EventRepository(EventProvider(Dio(BaseOptions(
            connectTimeout: 2000, receiveTimeout: 2000, sendTimeout: 2000)))))
      ..add(StartLoaded());
  }

  @override
  void dispose() {
    startBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: startBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Главная'),
          centerTitle: true,
        ),
        body: Start(),
      ),
    );
  }
}

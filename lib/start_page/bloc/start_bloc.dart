import 'dart:async';

import 'package:abitur/data/event_repository.dart';
import 'package:abitur/data/news_repository.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/news.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_event.dart';
part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  final INewsRepository newsRepository;
  final IEventRepository eventRepository;

  StartBloc({required this.eventRepository, required this.newsRepository})
      : super(StartState());

  @override
  Stream<StartState> mapEventToState(
    StartEvent event,
  ) async* {
    if (event is StartLoaded) yield* _mapStartListSLoadedToState();
  }

  Stream<StartState> _mapStartListSLoadedToState() async* {
    List<NewsArticle>? newsList;
    List<EventArticle>? eventList;
    bool isError = false;
    yield state.copyWith(
      loading: true,
    );

    try {
      final news = await newsRepository.loadNews(1, 3);
      newsList = news.elements;
    } catch (e) {
      isError = true;
    }

    try {
      final event = await eventRepository.loadEvents(1, 3);
      eventList = event.elements;
    } catch (e) {
      isError = true;
    }

    yield state.copyWith(
      news: newsList,
      event: eventList,
      isError: isError,
      loading: false,
    );
  }
}

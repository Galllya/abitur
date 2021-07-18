import 'dart:async';

import 'package:abitur/data/one_news_repository.dart';
import 'package:abitur/domain/news.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'one_news_event.dart';
part 'one_news_state.dart';

class OneNewsBloc extends Bloc<OneNewsEvent, OneNewsState> {
  final IOneNewsRepository oneNewsRepository;

  OneNewsBloc({required this.oneNewsRepository}) : super(OneNewsState());

  @override
  Stream<OneNewsState> mapEventToState(
    OneNewsEvent event,
  ) async* {
    if (event is OneNewsLoaded) {
      yield* _mapOneNewsListSLoadedToState(event);
    }
  }
  Stream<OneNewsState> _mapOneNewsListSLoadedToState(OneNewsLoaded ev) async*{
    yield state.copyWith(
      isLoading: true,
    );

    NewsArticle? news;
    try {
      news = await oneNewsRepository.loadEvents(ev.id);
    } catch (e) {
    }

    yield state.copyWith(
      isLoading: false,
      oneEvent: news,
    );
  }
}

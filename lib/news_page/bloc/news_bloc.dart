import 'dart:async';

import 'package:abitur/data/news_repository.dart';
import 'package:abitur/domain/news.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final INewsRepository newsRepository;

  NewsBloc({
    required this.newsRepository,
  }) : super(const NewsState());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is NewsStarted) {
      yield* _mapNewsListStartedToState();
    }
    if (event is NewsLoaded) {
      if (state.loading == false) yield* _mapNewsListLoadedToState(event);
    }
  }

  Stream<NewsState> _mapNewsListStartedToState() async* {
    add(const NewsLoaded(page: 1));
  }

  Stream<NewsState> _mapNewsListLoadedToState(NewsLoaded event) async* {
    yield state.copyWith(loading: true);
    try {
      final news = await newsRepository.loadNews(event.page, 150);

      yield state.copyWith(
        loading: false,
        news: [if (state.currentPage > 0) ...state.news, ...news.elements],
        currentPage: event.page,
      );
    } catch (e) {
      yield state.copyWith(loading: false);

      rethrow;
    }
  }
}

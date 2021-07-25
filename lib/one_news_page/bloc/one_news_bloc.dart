import 'dart:async';

import 'package:abitur/data/news_repository.dart';
import 'package:abitur/domain/news.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'one_news_event.dart';
part 'one_news_state.dart';

class OneNewsBloc extends Bloc<OneNewsEvent, OneNewsState> {
  final INewsRepository newsRepository;

  OneNewsBloc({required this.newsRepository}) : super(OneNewsState());

  @override
  Stream<OneNewsState> mapEventToState(
    OneNewsEvent event,
  ) async* {
    if (event is OneNewsLoaded) {
      if (event is ChangedFavorites) {
        yield* _mapChangedFavoritesToState();
      } else {
        yield* _mapOneNewsSLoadedToState(event);
      }
    }
  }

  /// В угоду читаемости лучше не сокращать названия переменных и использовать их "как есть"
  Stream<OneNewsState> _mapOneNewsSLoadedToState(OneNewsLoaded ev) async* {
    yield state.copyWith(
      isLoading: true,
    );

    /// здесь можно использовать аналогичную запись:
    // try {
    //   final newsArticle = await newsRepository.loadOneNews(ev.id);
    //   yield state.copyWith(isLoading: false, oneEvent: newsArticle);
    // } catch (e) {
    //   yield state.copyWith(isLoading: false);
    // }
    NewsArticle? news;
    try {
      news = await newsRepository.loadOneNews(ev.id);
    } catch (e) {}

    yield state.copyWith(
      isLoading: false,
      oneNews: news,
    );
  }

  Stream<OneNewsState> _mapChangedFavoritesToState() async* {
    /// тут мы можем определять, какой из методов репозитория дергать, на основании имеющихся данных о новости,
    /// которая хранится в state.oneNews
    if (state.oneNews!.isFavorite) {
      /// удаляем из избранного
    } else {
      /// добавляем в избранное

      await newsRepository.addToFavourites(state.oneNews!.id);
    }

    /// а тут можем сразу отправить событие на загрузку новости, чтобы обновить модель в соответствии с изменением
    /// в итоге изменится и кнопка и выше описанная кнопка, если мы нажмем на неё еще раз
  }
}

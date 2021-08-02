import 'dart:async';

import 'package:abitur/common/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:abitur/data/news_repository.dart';
import 'package:abitur/domain/news.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'one_news_event.dart';
part 'one_news_state.dart';

class OneNewsBloc extends Bloc<OneNewsEvent, OneNewsState> {
  final INewsRepository newsRepository;
  final FavoritesBloc favoritesBloc;

  OneNewsBloc({required this.favoritesBloc, required this.newsRepository})
      : super(OneNewsState());

  @override
  Stream<OneNewsState> mapEventToState(
    OneNewsEvent event,
  ) async* {
    if (event is OneNewsLoaded) {
      yield* _mapOneNewsSLoadedToState(event.id);
    } else {
      if (event is ChangedFavorites) {
        yield* _mapChangedFavoritesToState();
      }
    }
  }

  /// В угоду читаемости лучше не сокращать названия переменных и использовать их "как есть"
  Stream<OneNewsState> _mapOneNewsSLoadedToState(int id) async* {
    yield state.copyWith(
      isLoading: true,
    );

    try {
      final newsArticle = await newsRepository.loadOneNews(id);
      yield state.copyWith(isLoading: false, oneNews: newsArticle);
    } catch (e) {
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<OneNewsState> _mapChangedFavoritesToState() async* {
    /// тут мы можем определять, какой из методов репозитория дергать, на основании имеющихся данных о новости,
    /// которая хранится в state.oneNews
    if (state.oneNews!.isFavorite) {
      await newsRepository.deleteToFavourites(state.oneNews!.id);

      /// удаляем из избранного
    } else {
      /// добавляем в избранное

      await newsRepository.addToFavourites(state.oneNews!.id);
    }

    favoritesBloc.add(FavoritesLoaded());

    yield* _mapOneNewsSLoadedToState(state.oneNews!.id);

    /// а тут можем сразу отправить событие на загрузку новости, чтобы обновить модель в соответствии с изменением
    /// в итоге изменится и кнопка и выше описанная кнопка, если мы нажмем на неё еще раз
  }
}

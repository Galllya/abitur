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
      : super(const OneNewsState());

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
    if (state.oneNews!.isFavorite) {
      await newsRepository.deleteToFavourites(state.oneNews!.id);
    }
    if (state.oneNews!.isFavorite == false) {
      await newsRepository.addToFavourites(state.oneNews!.id);
    }
    favoritesBloc.add(FavoritesLoaded());
    yield* _mapOneNewsSLoadedToState(state.oneNews!.id);
  }
}

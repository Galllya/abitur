import 'dart:async';

import 'package:abitur/data/favotites_repository.dart';
import 'package:abitur/domain/favorites.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final IFavoritesRepository favoritesRepository;

  FavoritesBloc({required this.favoritesRepository}) : super(FavoritesState());

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is FavoritesLoaded) {
      yield* _mapFavoritesLoadedToState();
    }
  }

  Stream<FavoritesState> _mapFavoritesLoadedToState() async* {
    yield state.copyWith(loading: true);
    try {
      final favorites = await favoritesRepository.loadFavorites();

      yield state.copyWith(
        favorites: favorites.elements,
      );
    } catch (e) {
      yield state.copyWith(loading: false);

      rethrow;
    }
  }
}

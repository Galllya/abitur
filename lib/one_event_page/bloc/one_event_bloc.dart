import 'dart:async';

import 'package:abitur/common/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:abitur/data/event_repository.dart';
import 'package:abitur/domain/event.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'one_event_event.dart';
part 'one_event_state.dart';

class OneEventBloc extends Bloc<OneEventEvent, OneEventState> {
  final IEventRepository eventRepository;
  final FavoritesBloc favoritesBloc;

  OneEventBloc({required this.favoritesBloc, required this.eventRepository})
      : super(const OneEventState());

  @override
  Stream<OneEventState> mapEventToState(
    OneEventEvent event,
  ) async* {
    if (event is OneEventLoaded) {
      yield* _mapOneEventSLoadedToState(event.id);
    }
    if (event is ChangedFavorites) yield* _mapChangedFavoritesToState();
  }

  Stream<OneEventState> _mapOneEventSLoadedToState(int id) async* {
    yield state.copyWith(
      isLoading: true,
    );

    try {
      final newsArticle = await eventRepository.loadOneEvent(id);
      yield state.copyWith(isLoading: false, oneEvent: newsArticle);
    } catch (e) {
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<OneEventState> _mapChangedFavoritesToState() async* {
    if (state.oneEvent!.isFavorite == true) {
      await eventRepository.deleteEventToFavourites(state.oneEvent!.id);
    } else {
      await eventRepository.addEventToFavourites(state.oneEvent!.id);
    }
    favoritesBloc.add(FavoritesLoaded());

    yield* _mapOneEventSLoadedToState(state.oneEvent!.id);
  }
}

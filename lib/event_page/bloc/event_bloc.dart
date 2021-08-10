import 'dart:async';

import 'package:abitur/data/event_repository.dart';
import 'package:abitur/domain/event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final IEventRepository eventRepository;

  EventBloc({
    required this.eventRepository,
  }) : super(const EventState());

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is EventState) {
      yield* _mapNewsListStartedToState();
    }
    if (event is EventLoaded) {
      if (state.loading == false) yield* _mapNewsListLoadedToState(event);
    }
  }

  Stream<EventState> _mapNewsListStartedToState() async* {
    add(EventLoaded(page: 1));
  }

  Stream<EventState> _mapNewsListLoadedToState(EventLoaded event) async* {
    yield state.copyWith(loading: true);
    try {
      final news = await eventRepository.loadEvents(event.page, 150);

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

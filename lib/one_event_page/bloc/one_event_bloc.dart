import 'dart:async';

import 'package:abitur/data/event_repository.dart';
import 'package:abitur/domain/event.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'one_event_event.dart';
part 'one_event_state.dart';

class OneEventBloc extends Bloc<OneEventEvent, OneEventState> {
  final IEventRepository EventRepository;
  OneEventBloc({required this.EventRepository}) : super(OneEventState());

  @override
  Stream<OneEventState> mapEventToState(
    OneEventEvent event,
  ) async* {
    if (event is OneEventLoaded) {
      yield* _mapOneEventListSLoadedToState(event);
    }
  }

  Stream<OneEventState> _mapOneEventListSLoadedToState(
      OneEventLoaded ev) async* {
    yield state.copyWith(
      isLoading: true,
    );

    EventArticle? event;
    try {
      event = await EventRepository.loadOneEvent(ev.id);
    } catch (e) {}

    yield state.copyWith(
      isLoading: false,
      oneEvent: event,
    );
  }
}

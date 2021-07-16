import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'one_event_event.dart';
part 'one_event_state.dart';

class OneEventBloc extends Bloc<OneEventEvent, OneEventState> {
  OneEventBloc() : super(OneEventState());

  @override
  Stream<OneEventState> mapEventToState(
    OneEventEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

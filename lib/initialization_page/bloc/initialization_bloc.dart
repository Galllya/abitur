import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'initialization_event.dart';
part 'initialization_state.dart';

class InitializationBloc
    extends Bloc<InitializationEvent, InitializationState> {
  final SharedPreferences sharedPreferences;
  InitializationBloc({required this.sharedPreferences})
      : super(InitializationState());

  @override
  Stream<InitializationState> mapEventToState(
    InitializationEvent event,
  ) async* {
    if (event is LoadingEvent) {
      yield* _mapInitializationStateLiadingEvent();
    }
  }

  Stream<InitializationState> _mapInitializationStateLiadingEvent() async* {
    String? isToken = await sharedPreferences.getString('token');
    if (isToken != null) {
      yield state.copyWith(
        isLogged: true,
      );
    } else {
      yield state.copyWith(
        isLogged: false,
      );
    }
  }
}

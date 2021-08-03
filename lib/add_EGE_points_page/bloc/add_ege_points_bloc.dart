import 'dart:async';

import 'package:abitur/data/subjects_repository.dart';
import 'package:abitur/domain/subjects.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_ege_points_event.dart';
part 'add_ege_points_state.dart';

class AddEgePointsBloc extends Bloc<AddEgePointsEvent, AddEgePointsState> {
  final ISubjectsRepository subjectsRepository;

  AddEgePointsBloc({required this.subjectsRepository})
      : super(AddEgePointsState());

  @override
  Stream<AddEgePointsState> mapEventToState(
    AddEgePointsEvent event,
  ) async* {
    if (event is AddEgePointsLoaded) {
      yield* _mapAddEgePointsLoadedToState();
    }
  }

  Stream<AddEgePointsState> _mapAddEgePointsLoadedToState() async* {
    yield state.copyWith(loading: true);
    try {
      final subjects = await subjectsRepository.loadSubjects();

      yield state.copyWith(
        subjects: subjects,
      );
    } catch (e) {
      yield state.copyWith(loading: false);

      rethrow;
    }
  }
}

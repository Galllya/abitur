import 'dart:async';

import 'package:abitur/data/account_repository.dart';
import 'package:abitur/data/subjects_repository.dart';
import 'package:abitur/domain/subjects.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_ege_points_event.dart';
part 'add_ege_points_state.dart';

class AddEgePointsBloc extends Bloc<AddEgePointsEvent, AddEgePointsState> {
  final ISubjectsRepository subjectsRepository;
  final IAccountRepository accountRepository;
  AddEgePointsBloc(
      {required this.accountRepository, required this.subjectsRepository})
      : super(const AddEgePointsState());

  @override
  Stream<AddEgePointsState> mapEventToState(
    AddEgePointsEvent event,
  ) async* {
    if (event is AddEgePointsLoaded) {
      yield* _mapAddEgePointsLoadedToState();
    }
    if (event is PutSubjects) {
      yield* _mapPutSubjectsToState(event);
    }
  }

  Stream<AddEgePointsState> _mapAddEgePointsLoadedToState() async* {
    yield state.copyWith(loading: true);
    attemptGetSubjects();
  }

  Stream<AddEgePointsState> attemptGetSubjects() async* {
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

  Stream<AddEgePointsState> _mapPutSubjectsToState(
      PutSubjects putSubjects) async* {
    yield state.copyWith(success: true);
    try {
      accountRepository.accountProvider.putSubjects(putSubjects.formGroup);
    } catch (e) {
      yield state.copyWith(success: false);
      rethrow;
    }
  }
}

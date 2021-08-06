import 'dart:async';

import 'package:abitur/data/subjects_repository.dart';
import 'package:abitur/domain/subjects.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ISubjectsRepository subjectsRepository;

  ProfileBloc({required this.subjectsRepository}) : super(ProfileState());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadSubjects) yield* _mapLoadSubjectsProfileState();
  }

  Stream<ProfileState> _mapLoadSubjectsProfileState() async* {
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

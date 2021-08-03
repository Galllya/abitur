part of 'add_ege_points_bloc.dart';

@immutable
class AddEgePointsState {
  final bool loading;
  final List<SubjectsDate> subjects;

  const AddEgePointsState({
    this.loading = false,
    this.subjects = const [],
  });

  AddEgePointsState copyWith({
    bool? loading,
    List<SubjectsDate>? subjects,
  }) {
    return AddEgePointsState(
      subjects: subjects ?? this.subjects,
      loading: loading ?? this.loading,
    );
  }
}

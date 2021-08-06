part of 'add_ege_points_bloc.dart';

@immutable
class AddEgePointsState {
  final bool loading;
  final List<SubjectsDate> subjects;
  final bool? success;

  const AddEgePointsState({
    this.loading = false,
    this.subjects = const [],
    this.success,
  });

  AddEgePointsState copyWith({
    bool? loading,
    List<SubjectsDate>? subjects,
    bool? success,
  }) {
    return AddEgePointsState(
      subjects: subjects ?? this.subjects,
      loading: loading ?? this.loading,
      success: success ?? this.success,
    );
  }
}

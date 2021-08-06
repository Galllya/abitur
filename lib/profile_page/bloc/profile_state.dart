part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final bool? loading;
  final List<SubjectsDate> subjects;

  const ProfileState({
    this.loading,
    this.subjects = const [],
  });

  ProfileState copyWith({
    bool? loading,
    List<SubjectsDate>? subjects,
    bool? success,
  }) {
    return ProfileState(
      subjects: subjects ?? this.subjects,
      loading: loading ?? this.loading,
    );
  }
}

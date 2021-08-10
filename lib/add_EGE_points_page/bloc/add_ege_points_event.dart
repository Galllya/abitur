part of 'add_ege_points_bloc.dart';

@immutable
abstract class AddEgePointsEvent {}

class AddEgePointsLoaded extends AddEgePointsEvent {}

class PutSubjects extends AddEgePointsEvent {
  final Map<String, dynamic> formGroup;
  PutSubjects({required this.formGroup});
}

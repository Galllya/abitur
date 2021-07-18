part of 'one_event_bloc.dart';

@immutable
abstract class OneEventEvent {}

class OneEventLoaded extends OneEventEvent {
  final int id;
  OneEventLoaded({required this.id});
}

part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventStarted extends EventEvent {}

class EventLoaded extends EventEvent {
  final int page;

  EventLoaded({required this.page});
}

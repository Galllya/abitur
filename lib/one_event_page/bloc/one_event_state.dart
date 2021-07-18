part of 'one_event_bloc.dart';

@immutable
class OneEventState {
  final bool isLoading;
  final EventArticle? oneEvent;

  const OneEventState({this.isLoading = true, this.oneEvent});

  OneEventState copyWith({
    bool? isLoading,
    EventArticle? oneEvent,
  }) {
    return OneEventState(
      isLoading: isLoading ?? this.isLoading,
      oneEvent: oneEvent ?? this.oneEvent,
    );
  }
}

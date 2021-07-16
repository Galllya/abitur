part of 'event_bloc.dart';

@immutable
class EventState {
  final int currentPage;

  final bool loading;

  final List<EventArticle> news;

  const EventState({
    this.currentPage = 0,
    this.loading = false,
    this.news = const [],
  });

  EventState copyWith({
    bool? loading,
    List<EventArticle>? news,
    int? currentPage,
  }) {
    return EventState(
      news: news ?? this.news,
      loading: loading ?? this.loading,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

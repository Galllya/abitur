part of 'start_bloc.dart';

@immutable
class StartState {
  final bool loading;
  final List<NewsArticle>? news;
  final List<EventArticle>? event;
  final bool isError;

  const StartState(
      {this.news, this.loading = true, this.event, this.isError = false});

  StartState copyWith({
    bool? loading,
    List<NewsArticle>? news,
    List<EventArticle>? event,
    bool? isError,
  }) {
    return StartState(
      news: news ?? this.news,
      event: event ?? this.event,
      loading: loading ?? this.loading,
      isError: isError ?? this.isError,
    );
  }
}

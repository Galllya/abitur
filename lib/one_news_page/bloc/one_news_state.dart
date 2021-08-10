part of 'one_news_bloc.dart';

@immutable
class OneNewsState {
  final bool isLoading;
  final NewsArticle? oneNews;

  const OneNewsState({this.isLoading = true, this.oneNews});

  OneNewsState copyWith({
    bool? isLoading,
    NewsArticle? oneNews,
  }) {
    return OneNewsState(
      isLoading: isLoading ?? this.isLoading,
      oneNews: oneNews ?? this.oneNews,
    );
  }
}

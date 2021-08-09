part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {
  const NewsEvent();
}

class NewsStarted extends NewsEvent {}

class NewsLoaded extends NewsEvent {
  final int page;

  const NewsLoaded({required this.page});
}

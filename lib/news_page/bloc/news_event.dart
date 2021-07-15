part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class NewsStarted extends NewsEvent {}

class NewsLoaded extends NewsEvent {
  final int page;

  NewsLoaded({required this.page});
}

class NewsReset extends NewsEvent {}


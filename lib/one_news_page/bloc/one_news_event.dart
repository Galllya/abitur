part of 'one_news_bloc.dart';

@immutable
abstract class OneNewsEvent {}

class OneNewsLoaded extends OneNewsEvent {
  final int id;
  OneNewsLoaded({required this.id});
}
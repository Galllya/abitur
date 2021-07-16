part of 'news_bloc.dart';

/// Класс, описывающий текущее состояние bloc`а
///
/// Декоратор @immutable отмечает то, что поля этого класса не должны изменяться
/// на протяжении всей жизни экземпляра класса и его наследников
@immutable
class NewsState {
  /// Номер текущей страницы
  final int currentPage;

  /// Флаг загрузки
  final bool loading;

  /// Список новостей
  final List<NewsArticle> news;

  const NewsState({
    this.currentPage = 0,
    this.loading = false,
    this.news = const [],
  });

  /// Создаем новый экземпляр состояния при помощи копирования
  NewsState copyWith({
    bool? loading,
    List<NewsArticle>? news,
    int? currentPage,
  }) {
    /// Конструкция "news ?? this.news" позволяет перенести в новый объект
    /// значение поля старого объекта, если оно не было передано в виде аргумента copyWith
    return NewsState(
      news: news ?? this.news,
      loading: loading ?? this.loading,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

import 'dart:async';

import 'package:abitur/data/news_repository.dart';
import 'package:abitur/domain/news.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

/// Сам bloc, исходя из названия, можем называть его "компонентом бизнес-логики",
/// в данном случае это "компонент бизнес-логики списка новостей"
///
/// Он представляет собой поток данных, который изменяется(или не изменяется),
/// в зависимости от событий, которые поступают в обработку
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final INewsRepository newsRepository;

  /// В конструктор мы можем прокидывать внешние зависимости,
  /// которые могут потребоваться компоненту бизнес-логики
  ///
  /// В родительский конструктор мы передаем желаемое исходное состояние
  NewsBloc({
    required this.newsRepository,
  }) : super(NewsState());

  /// Метод, отвечающий за обработку событий и изменение состояния в зависимости от них
  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    /// Так как библиотека используется со стандартным способом описания событий,
    /// используется оператор ветвления, который проверяет входящее событие на принадлежность к классу
    if (event is NewsStarted) {
      yield* _mapNewsListStartedToState();
    } else if (event is NewsLoaded) {
      /// Если НЕ происходит загрузка, то начинаем загрузку
      if (state.loading == false) yield* _mapNewsListLoadedToState(event);
    }
  }

  Stream<NewsState> _mapNewsListStartedToState() async* {
    /// Инициализирующее событие блока может также инициировать другие события,
    /// (и не только инициализирующее событие, но и любые другие)
    /// например, нам нужно сразу начать грузить новости с первой страницы:
    add(NewsLoaded(page: 1));
  }

  Stream<NewsState> _mapNewsListLoadedToState(NewsLoaded event) async* {
    /// Отправляем в поток состояние, которое говорит что идет загрузка
    yield state.copyWith(loading: true);
    try {
      /// Загружаем данные
      final news = await newsRepository.loadNews(event.page, 150);

      /// Отправляем в поток состояние, которое содержит уже новости и флаг загруки переключаем в false
      /// а также обновляем страницу
      yield state.copyWith(
        loading: false,
        news: [if (state.currentPage > 0) ...state.news, ...news.elements],
        currentPage: event.page,
      );
    } catch (e) {
      yield state.copyWith(loading: false);

      /// rethrow; используется для прокидывания ошибки в BlocObserver
      rethrow;
    }
  }
}

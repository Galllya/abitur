import 'package:abitur/domain/news.dart';
import 'package:abitur/domain/pagination.dart';

import 'news_provider.dart';

abstract class INewsRepository {
  final NewsProvider newsProvider;

  INewsRepository(this.newsProvider);

  Future<Pagination<NewsArticle>> loadNews(int page, int size);
  Future<NewsArticle> loadOneNews(int id);
  Future<void> addToFavourites(int id);
  Future<void> deleteToFavourites(int id);
}

class NewsRepository extends INewsRepository {
  NewsRepository(NewsProvider newsProvider) : super(newsProvider);

  @override
  Future<Pagination<NewsArticle>> loadNews(int page, int size) {
    return newsProvider.loadNews(page: page, size: size);
  }

  @override
  Future<NewsArticle> loadOneNews(int id) {
    return newsProvider.loadOneNews(id: id);
  }

  @override
  Future<void> addToFavourites(int id) {
    return newsProvider.addToFavourites(id: id);
  }

  @override
  Future<void> deleteToFavourites(int id) {
    return newsProvider.deleteToFavourites(id: id);
  }
}

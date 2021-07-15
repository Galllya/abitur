import 'package:abitur/domain/news.dart';
import 'package:abitur/domain/pagination.dart';

import 'news_provider.dart';

abstract class INewsRepository {
  final NewsProvider newsProvider;

  INewsRepository(this.newsProvider);

  Future<Pagination<NewsArticle>> loadNews(int page, {int size = 20});
}

class NewsRepository extends INewsRepository {
  NewsRepository(NewsProvider newsProvider) : super(newsProvider);

  @override
  Future<Pagination<NewsArticle>> loadNews(int page, {int size = 20}) {
    return newsProvider.loadNews(page: page, size: size);
  }
}

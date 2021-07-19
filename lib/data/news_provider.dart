import 'package:abitur/common/data/provider.dart';
import 'package:abitur/common/network/application_rest_client.dart';
import 'package:abitur/data/rest_client_provider.dart';
import 'package:abitur/domain/news.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:dio/dio.dart';

class NewsProvider extends RestClientProvider {
  NewsProvider(ApplicationRestClient applicationRestClient)
      : super(applicationRestClient);

  Future<Pagination<NewsArticle>> loadNews(
      {required int page, int? size}) async {
    return applicationRestClient.loadNews(page: page, size: size);
  }

  Future<NewsArticle> loadOneNews({required int id}) async {
    return applicationRestClient.loadOneNews(id: id);
  }
}

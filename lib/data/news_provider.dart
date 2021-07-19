import 'package:abitur/common/data/provider.dart';
import 'package:abitur/domain/news.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:dio/dio.dart';

class NewsProvider extends DioProvider {
  NewsProvider(Dio dio) : super(dio);

  Future<Pagination<NewsArticle>> loadNews(
      {required int page, int? size}) async {
    try {
      final response = await dio.get(
        'http://abiturient.paraweb.media/api/v1/News?page=$page&size=$size',
      );
      return Pagination.fromJson(response.data,
          (json) => NewsArticle.fromJson(json as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  Future<NewsArticle> loadOneNews({required int id}) async {
    try {
      final String URL = 'http://abiturient.paraweb.media/api/v1/News/${id}';
      var response = await Dio().get(URL);
      final model = NewsArticle.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}

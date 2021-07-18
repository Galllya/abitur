import 'package:abitur/common/data/provider.dart';
import 'package:abitur/domain/news.dart';
import 'package:dio/dio.dart';

class OneNewsProvider extends DioProvider {
  OneNewsProvider(Dio dio) : super(dio);

  Future<NewsArticle> loadEvents({required int id}) async {
    try {
      final String URL =
          'http://abiturient.paraweb.media/api/v1/News/${id}';
      var response = await Dio().get(URL);
      final model = NewsArticle.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}

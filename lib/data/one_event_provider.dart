import 'package:abitur/common/data/provider.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:dio/dio.dart';

class OneEventProvider extends DioProvider {
  OneEventProvider(Dio dio) : super(dio);

  Future<Pagination<EventArticle>> loadEvents({required int id}) async {
    try {
      final response = await dio.get(
        'http://abiturient.paraweb.media/api/v1/Events/${id}',
      );
      return Pagination.fromJson(response.data,
          (json) => EventArticle.fromJson(json as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:abitur/common/data/provider.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:dio/dio.dart';

class EventProvider extends DioProvider {
  EventProvider(Dio dio) : super(dio);

  Future<Pagination<EventArticle>> loadEvents(
      {required int page, int? size}) async {
    try {
      final response = await dio.get(
        'http://abiturient.paraweb.media/api/v1/Events?page=${page}&size=$size&forAbiturients=false&calendar=false',
      );
      return Pagination.fromJson(response.data,
          (json) => EventArticle.fromJson(json as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }
}

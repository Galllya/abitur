import 'package:abitur/common/data/provider.dart';
import 'package:abitur/domain/event.dart';
import 'package:dio/dio.dart';

class OneEventProvider extends DioProvider {
  OneEventProvider(Dio dio) : super(dio);

  Future<EventArticle> loadEvents({required int id}) async {
    try {
      final String URL =
          'http://abiturient.paraweb.media/api/v1/Events/${id}';
      var response = await Dio().get(URL);
      final model = EventArticle.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}

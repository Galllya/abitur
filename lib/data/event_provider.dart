import 'package:abitur/common/network/application_rest_client.dart';
import 'package:abitur/data/rest_client_provider.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/pagination.dart';

class EventProvider extends RestClientProvider {
  EventProvider(ApplicationRestClient applicationRestClient)
      : super(applicationRestClient);

  Future<Pagination<EventArticle>> loadEvents(
      {required int page, int? size}) async {
    return applicationRestClient.loadEvents(page: page, size: size);
  }

  Future<EventArticle> loadOneEvents({required int id}) async {
    return applicationRestClient.loadEvent(id: id);
  }
}

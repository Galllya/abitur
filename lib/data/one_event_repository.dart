import 'package:abitur/data/event_provider.dart';
import 'package:abitur/data/one_event_provider.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/pagination.dart';

abstract class IOneEventRepository {
  final OneEventProvider oneEventProvider;

  IOneEventRepository(this.oneEventProvider);

  Future<Pagination<EventArticle>> loadEvents(int id);
}

class OneEventRepository extends IOneEventRepository {
  OneEventRepository(OneEventProvider oneEventProvider)
      : super(oneEventProvider);

  @override
  Future<Pagination<EventArticle>> loadEvents(int id) {
    return oneEventProvider.loadEvents(id: id);
  }
}

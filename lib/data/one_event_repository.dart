import 'package:abitur/data/one_event_provider.dart';
import 'package:abitur/domain/event.dart';

abstract class IOneEventRepository {
  final OneEventProvider oneEventProvider;

  IOneEventRepository(this.oneEventProvider);

  Future<EventArticle> loadEvents(int id);
}

class OneEventRepository extends IOneEventRepository {
  OneEventRepository(OneEventProvider oneEventProvider)
      : super(oneEventProvider);

  @override
  Future<EventArticle> loadEvents(int id) {
    return oneEventProvider.loadEvents(id: id);
  }
}

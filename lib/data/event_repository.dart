import 'package:abitur/data/event_provider.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/pagination.dart';

abstract class IEventRepository {
  final EventProvider eventProvider;

  IEventRepository(this.eventProvider);

  Future<Pagination<EventArticle>> loadEvents(int page, int size);
  Future<EventArticle> loadOneEvent(int id);
  Future<void> addEventToFavourites(int id);
  Future<void> deleteEventToFavourites(int id);
}

class EventRepository extends IEventRepository {
  EventRepository(EventProvider eventProvider) : super(eventProvider);

  @override
  Future<Pagination<EventArticle>> loadEvents(int page, int size) {
    return eventProvider.loadEvents(page: page, size: size);
  }

  @override
  Future<EventArticle> loadOneEvent(int id) {
    return eventProvider.loadOneEvents(id: id);
  }

  @override
  Future<void> addEventToFavourites(int id) {
    return eventProvider.addEventToFavourites(id: id);
  }

  @override
  Future<void> deleteEventToFavourites(int id) {
    return eventProvider.deleteEventToFavourites(id: id);
  }
}

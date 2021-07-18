import 'package:abitur/data/one_news_provider.dart';
import 'package:abitur/domain/news.dart';

abstract class IOneNewsRepository {
  final OneNewsProvider oneNewstProvider;

  IOneNewsRepository(this.oneNewstProvider);

  Future<NewsArticle> loadEvents(int id);
}

class OneNewsRepository extends IOneNewsRepository {
  OneNewsRepository(OneNewsProvider oneNewsProvider)
      : super(oneNewsProvider);

  @override
  Future<NewsArticle> loadEvents(int id) {
    return oneNewstProvider.loadEvents(id: id);
  }
}

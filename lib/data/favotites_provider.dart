import 'package:abitur/common/network/application_rest_client.dart';
import 'package:abitur/data/rest_client_provider.dart';
import 'package:abitur/domain/favorites.dart';
import 'package:abitur/domain/pagination.dart';

class FavoritesProvider extends RestClientProvider {
  FavoritesProvider(ApplicationRestClient applicationRestClient)
      : super(applicationRestClient);

  Future<Pagination<FavoritesDate>> loadFavorites(
      /*{required int page, int? size}*/) async {
    return applicationRestClient.loadFavorites(/*page: page, size: size*/);
  }
}

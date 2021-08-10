import 'package:abitur/data/favotites_provider.dart';
import 'package:abitur/domain/favorites.dart';
import 'package:abitur/domain/pagination.dart';

abstract class IFavoritesRepository {
  final FavoritesProvider favoritesProvider;

  IFavoritesRepository(this.favoritesProvider);

  Future<Pagination<FavoritesDate>> loadFavorites();
}

class FavoritesRepository extends IFavoritesRepository {
  FavoritesRepository(FavoritesProvider favoritesProvider)
      : super(favoritesProvider);

  @override
  Future<Pagination<FavoritesDate>> loadFavorites() {
    return favoritesProvider.loadFavorites();
  }
}

import 'package:abitur/data/favotites_provider.dart';
import 'package:abitur/domain/favorites.dart';
import 'package:abitur/domain/pagination.dart';

abstract class IFavoritesRepository {
  final FavoritesProvider favoritesProvider;

  IFavoritesRepository(this.favoritesProvider);

  Future<Pagination<FavoritesDate>> loadFavorites(/*int page, int size*/);
}

class FavoritesRepository extends IFavoritesRepository {
  FavoritesRepository(FavoritesProvider favoritesProvider)
      : super(favoritesProvider);

  @override
  Future<Pagination<FavoritesDate>> loadFavorites(/*int page, int size*/) {
    return favoritesProvider.loadFavorites(/*page: page, size: size*/);
  }
}

import 'package:abitur/domain/account.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/favorites.dart';
import 'package:abitur/domain/news.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:abitur/domain/token.dart';
import 'package:abitur/domain/transfer_login_and_password.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'application_rest_client.g.dart';

const int _kPageSize = 100;
const int kQuestionsPageSize = _kPageSize;
const int kCommentsPageSize = 5;

@RestApi(baseUrl: 'http://abiturient.paraweb.media/api/v1')
abstract class ApplicationRestClient {
  factory ApplicationRestClient(Dio dio, {String baseUrl}) =
      _ApplicationRestClient;

  static const String kEvents = 'Events';

  @GET('/$kEvents/')
  Future<Pagination<EventArticle>> loadEvents({
    @Query('page') required int page,
    @Query('size') int? size = _kPageSize,
  });
  @GET('/$kEvents/{id}')
  Future<EventArticle> loadEvent({
    @Path('id') required int id,
  });

  static const String kNews = 'News';
  @GET('/$kNews/')
  Future<Pagination<NewsArticle>> loadNews({
    @Query('page') required int page,
    @Query('size') int? size = _kPageSize,
  });
  @GET('/$kNews/{id}')
  Future<NewsArticle> loadOneNews({
    @Path('id') required int id,
  });

  static const String kAccount = 'Account';
  @GET('/$kAccount')
  Future<AccountData> loadAccount();

  static const String kToken = 'Token';
  @GET('/$kToken')
  Future<TokenData> loadToken();

  @POST('/$kToken')
  Future<TokenData> authorize({
    @Body() required LoginPasswordModel loginPasswordModel,
  });

  @POST('/$kNews/{id}/Favorite')
  Future<void> addToFavourites({
    @Path('id') required int id,
  });

  @DELETE('/$kNews/{id}/Favorite')
  Future<void> deleteToFavourites({
    @Path('id') required int id,
  });

  @POST('/$kEvents/{id}/Favorite')
  Future<void> addEventToFavourites({
    @Path('id') required int id,
  });

  @DELETE('/$kEvents/{id}/Favorite')
  Future<void> deleteEventToFavourites({
    @Path('id') required int id,
  });

  static const String kFavorites = "Favorites";
  @GET('/$kFavorites/')
  Future<Pagination<FavoritesDate>> loadFavorites(
      //     {
      //   @Query('page') required int page,
      //   @Query('size') int? size = _kPageSize,
      // }
      );
}

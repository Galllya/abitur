import 'dart:io';

import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/pagination.dart';
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
    @Query('page') int page,
    @Query('size') int size = _kPageSize,
  });
  @GET('/$kEvents/{id}')
  Future<EventArticle> loadEvent({
    @Path('id') int id,
  });
}

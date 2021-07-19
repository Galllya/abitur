import 'package:abitur/common/network/application_rest_client.dart';
import 'package:abitur/data/event_repository.dart';
import 'package:abitur/data/news_provider.dart';
import 'package:abitur/data/news_repository.dart';
import 'package:abitur/start_page/view/start_page.dart';
import 'package:abitur/style/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'data/event_provider.dart';

void main() async {
  await initializeDateFormatting('ru_RU', null);
  var options = BaseOptions(
      baseUrl: 'http://abiturient.paraweb.media/api/v1',
      connectTimeout: 2000,
      receiveTimeout: 2000,
      sendTimeout: 2000);

  final dio = Dio(options);

  final applicationRestClient = ApplicationRestClient(dio);

  final newsProvider = NewsProvider(applicationRestClient);
  final eventProvider = EventProvider(applicationRestClient);
  final newsRepo = NewsRepository(newsProvider);
  final eventRepo = EventRepository(eventProvider);
  runApp(MultiProvider(providers: [
    Provider<EventRepository>.value(value: eventRepo),
    Provider<NewsRepository>.value(value: newsRepo)
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      home: StartPage(),
    );
  }
}

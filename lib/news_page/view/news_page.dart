import 'package:abitur/data/news_provider.dart';
import 'package:abitur/data/news_repository.dart';
import 'package:abitur/news_page/bloc/news_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsPage> {
  late NewsBloc newsListBloc;

  @override
  void initState() {
    super.initState();
    newsListBloc = NewsBloc(
      newsRepository: NewsRepository(NewsProvider(Dio(BaseOptions(
          connectTimeout: 2000, receiveTimeout: 2000, sendTimeout: 2000)))),
    )..add(NewsLoaded(page: 1));
  }

  @override
  void dispose() {
    newsListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: newsListBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Новости'),
          centerTitle: true,
        ),
        body: News(),
      ),
    );
  }
}

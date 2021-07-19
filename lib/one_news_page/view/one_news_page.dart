import 'package:abitur/data/news_repository.dart';
import 'package:abitur/one_news_page/bloc/one_news_bloc.dart';
import 'package:abitur/one_news_page/view/one_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneNewsPage extends StatefulWidget {
  final int _id;
  const OneNewsPage({Key? key, required int id}) : _id = id;

  @override
  _OneNewsListPageState createState() => _OneNewsListPageState();
}

class _OneNewsListPageState extends State<OneNewsPage> {
  late OneNewsBloc oneNewsBloc;

  @override
  void initState() {
    super.initState();
    oneNewsBloc = OneNewsBloc(
      newsRepository: context.read<NewsRepository>(),
    )..add(OneNewsLoaded(id: widget._id));
  }

  @override
  void dispose() {
    oneNewsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: oneNewsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Новость'),
          centerTitle: true,
        ),
        body: OneNews(),
      ),
    );
  }
}

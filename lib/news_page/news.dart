import 'package:abitur/models/news_model.dart';
import 'package:abitur/models/pagination_model.dart';
import 'package:abitur/start_page/widgets/news_section_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<News> {
  final _scrollController = ScrollController();
  final dio = Dio();
  List<NewsViewModel> news = [];
  bool haveConnection = true;
  bool loadingNews = false;
  bool loadingEvent = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadnews();
    _scrollController.addListener(_onScroll);
  }

  loadnews() async {
    final String URL =
        'http://abiturient.paraweb.media/api/v1/News?page=1&size=100';
    try {
      var response = await Dio().get(URL);

      final pagination = PaginationModel.fromJson(response.data,
          (json) => NewsViewModel.fromJson(json as Map<String, dynamic>));
      setState(() {
        news = pagination.elements;
        loadingNews = true;
      });
    } catch (e) {
      haveConnection = false;
      loadingNews = true;
      throw Exception('Ошибка загрузки новостей');
    }
  }

  void _onScroll() {
    if (_isBottom) {
      /// вызываем загрузку следующей страницы;
    }
  }

  /// проверяем на достижения нижней позиции скролла
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Новости"),
          centerTitle: true,
        ),
        body: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemBuilder: (BuildContext context, int index) {
              /// выводим индикатор загрузки, если индекс выходит за длину массива
              if (index >= news.length)
                return const CircularProgressIndicator();

              final element = NewsSectionCard(
                newsViewModel: news.elementAt(index),
              );
              return element;
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: news.length));
  }
}

class PaginationNewsModel<T> {
  final int totalCount;
  final List<T> elements;

  const PaginationNewsModel({
    required this.elements,
    required this.totalCount,
  });
}

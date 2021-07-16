import 'package:abitur/common/widgets/news_section_card.dart';
import 'package:abitur/domain/news.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsLater extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewsLater> {
  final _scrollController = ScrollController();
  final dio = Dio();

  int currentPage = 1;
  Pagination<NewsArticle>? newsPagination;

  bool haveConnection = true;
  bool loadingNews = false;
  bool loadingEvent = false;

  @override
  void initState() {
    super.initState();

    loadNews(currentPage);

    _scrollController.addListener(_onScroll);
  }

  void loadNews(int page) async {
    setState(() {
      loadingNews = true;
    });
    final String url =
        'http://abiturient.paraweb.media/api/v1/News?page=$page&size=10';
    try {
      var response = await dio.get(url);

      final pagination = Pagination.fromJson(response.data,
          (json) => NewsArticle.fromJson(json as Map<String, dynamic>));
      setState(() {
        print("currentPage: $currentPage          page: $page");
        currentPage = page;
        newsPagination = Pagination<NewsArticle>(
          [
            if (newsPagination != null) ...newsPagination!.elements,
            ...pagination.elements,
          ],
          pagination.totalCount,
        );
        loadingNews = false;
      });
    } catch (e) {
      setState(() {
        loadingNews = false;
      });
      throw Exception('Ошибка загрузки новостей');
    }
  }

  void _onScroll() {
    // if (newsPagination != null &&
    //     newsPagination!.totalCount != newsPagination!.elements.length &&
    //     loadingNews)
    if (_isBottom && !loadingNews) {
      loadNews(currentPage + 1);
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
      body: newsPagination != null
          ? ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemBuilder: (BuildContext context, int index) {
                /// выводим индикатор загрузки, если индекс выходит за длину массива
                if (index >= newsPagination!.elements.length)
                  return const CircularProgressIndicator();

                final element = NewsSectionCard(
                  newsViewModel: newsPagination!.elements.elementAt(index),
                );
                return element;
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount:
                  newsPagination!.totalCount > newsPagination!.elements.length
                      ? newsPagination!.elements.length + 1
                      : newsPagination!.elements.length,
            )
          : CircularProgressIndicator(),
    );
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

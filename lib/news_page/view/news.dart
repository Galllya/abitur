import 'package:abitur/news_page/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Для реализации пагинации нам потребуется иметь контроллер скролла списка новостей,
/// для этого потребуется StatefulWidget
class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<News> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    /// Проверку на "происходит ли сейчас загрузка" мы выносим в слой бизнес-логики
    if (_isBottom) {
      context.read<NewsBloc>().add(
          NewsLoaded(page: context.read<NewsBloc>().state.currentPage + 1));
    }
  }

  /// проверяем на достижения нижней позиции скролла
  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    /// Для отрисовки интерфейса в зависимости от состояния блока используется
    /// специальный виджет, который перерисовывается при изменении состояния
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (BuildContext context, NewsState state) {
        if (state.loading) return Center(child: CircularProgressIndicator());
        if (state.news.isEmpty) {
          return Center(child: Text('Нет новостей'));
        } else
          return RefreshIndicator(
            /// этот виджет позволяет сделать обновление списка через pull-to-refresh
            onRefresh: () async {
              // context.read<NewsListBloc>().add(NewsListLoaded(page: 1));
              // или, аналогичная запись
              BlocProvider.of<NewsBloc>(context).add(NewsLoaded(page: 1));
              return Future.value();
            },
            child: ListView(
              controller: scrollController,
              children: [
                ...state.news.map(
                  (newsArticle) => ListTile(
                    title: Text('${newsArticle.title}'),
                  ),
                ),
              ],
            ),
          );
      },
    );
  }
}

// import 'package:abitur/domain/news.dart';
// import 'package:abitur/domain/pagination.dart';
// import 'package:abitur/start_page/widgets/news_section_card.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// class News extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<News> {
//   final _scrollController = ScrollController();
//   final dio = Dio();
//
//   int currentPage = 1;
//   Pagination<NewsArticle>? newsPagination;
//
//   bool haveConnection = true;
//   bool loadingNews = false;
//   bool loadingEvent = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     loadNews(currentPage);
//
//     _scrollController.addListener(_onScroll);
//   }
//
//   void loadNews(int page) async {
//     if (newsPagination != null) {
//       if (newsPagination!.elements.length == newsPagination!.totalCount) {
//         return;
//       }
//     }
//     setState(() {
//       loadingNews = true;
//     });
//     final String url =
//         'http://abiturient.paraweb.media/api/v1/News?page=$page&size=10';
//     try {
//       var response = await dio.get(url);
//
//       final pagination = Pagination.fromJson(response.data,
//           (json) => NewsArticle.fromJson(json as Map<String, dynamic>));
//       setState(() {
//         print("currentPage: $currentPage          page: $page");
//         currentPage = page;
//         newsPagination = Pagination<NewsArticle>(
//           [
//             if (newsPagination != null) ...newsPagination!.elements,
//             ...pagination.elements,
//           ],
//           pagination.totalCount,
//         );
//         loadingNews = false;
//       });
//     } catch (e) {
//       setState(() {
//         loadingNews = false;
//         haveConnection = false;
//       });
//       throw Exception('Ошибка загрузки новостей');
//     }
//   }
//
//   void _onScroll() {
//     if (_isBottom && !loadingNews) {
//       loadNews(currentPage + 1);
//     }
//   }
//
//   /// проверяем на достижения нижней позиции скролла
//   bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * 0.9);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Новости"),
//           centerTitle: true,
//         ),
//         body: haveConnection
//             ? newsPagination != null
//                 ? ListView.separated(
//                     controller: _scrollController,
//                     padding: const EdgeInsets.all(16),
//                     itemBuilder: (BuildContext context, int index) {
//                       /// выводим индикатор загрузки, если индекс выходит за длину массива
//                       if (index >= newsPagination!.elements.length)
//                         return const CircularProgressIndicator();
//
//                       final element = NewsSectionCard(
//                         newsViewModel:
//                             newsPagination!.elements.elementAt(index),
//                       );
//                       return element;
//                     },
//                     separatorBuilder: (context, index) =>
//                         const SizedBox(height: 16),
//                     itemCount: newsPagination!.totalCount >
//                             newsPagination!.elements.length
//                         ? newsPagination!.elements.length + 1
//                         : newsPagination!.elements.length,
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [CircularProgressIndicator()])
//             : Center(
//                 child: Text(
//                   'Ошибка при загрузке новостей',
//                   style: TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//               ));
//   }
// }

import 'package:abitur/common/widgets/news_section_card.dart';
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
  int number = 0;
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
    // if (_isBottom) {
    //   context.read<NewsBloc>().add(
    //       NewsLoaded(page: context.read<NewsBloc>().state.currentPage + 1));
    // }
  }

  /// проверяем на достижения нижней позиции скролла

  @override
  Widget build(BuildContext context) {
    /// Для отрисовки интерфейса в зависимости от состояния блока используется
    /// специальный виджет, который перерисовывается при изменении состояния
    return BlocBuilder<NewsBloc, NewsState>(
        builder: (BuildContext context, NewsState state) {
      if (state.loading && state.news.isEmpty)
        return Center(child: CircularProgressIndicator());
      if (state.news.isEmpty) {
        return Center(child: Text('Нет новостей'));
      } else {
        return Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              ...state.news.map((newsArticle) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: NewsSectionCard(
                      newsViewModel: newsArticle,
                    ),
                  )),
            ],
          ),
        );
      }
    });
  }
}

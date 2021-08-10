import 'package:abitur/common/widgets/news_section_card.dart';
import 'package:abitur/news_page/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (BuildContext context, NewsState state) {
        if (state.loading && state.news.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.news.isEmpty) {
          return const Center(child: Text('Нет новостей'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: scrollController,
              children: [
                ...state.news.map(
                  (newsArticle) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: NewsSectionCard(
                      newsViewModel: newsArticle,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

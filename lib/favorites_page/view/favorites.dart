import 'package:abitur/common/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:abitur/common/widgets/news_section_card.dart';
import 'package:abitur/favorites_page/view/widgets/favorites_card.dart';
import 'package:abitur/news_page/view/news.dart';
import 'package:abitur/one_event_page/view/one_event_page.dart';
import 'package:abitur/one_news_page/view/one_news_page.dart';
import 'package:abitur/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final account = context.read<FavoritesBloc>().state;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (BuildContext context, FavoritesState state) {
      if (state.loading && state.favorites.isEmpty)
        return Center(child: CircularProgressIndicator());
      if (state.favorites.isEmpty) {
        return Center(child: Text('Нет новостей'));
      } else {
        return Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              ...state.favorites.map(
                (FavoritesDate) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: FavoritesCard(
                    favoritesDate: FavoritesDate,
                    onButtonTap: () {
                      FavoritesDate.type == "News"
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OneNewsPage(id: FavoritesDate.id)))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OneEventPage(id: FavoritesDate.id)));
                    },
                  ),
                ),
              )
            ],
          ),
        );
      }
    });
  }
}

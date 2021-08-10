import 'package:abitur/common/bloc/favorite_bloc/favorites_bloc.dart';
import 'package:abitur/favorites_page/widgets/favorites_card.dart';
import 'package:abitur/one_event_page/view/one_event_page.dart';
import 'package:abitur/one_news_page/view/one_news_page.dart';
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
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (BuildContext context, FavoritesState state) {
      if (state.loading && state.favorites.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.favorites.isEmpty) {
        return const Center(child: Text('Нет новостей'));
      } else {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              ...state.favorites.map(
                (favoritesDate) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FavoritesCard(
                    favoritesDate: favoritesDate,
                    onButtonTap: () {
                      favoritesDate.type == 'News'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OneNewsPage(id: favoritesDate.id)))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OneEventPage(id: favoritesDate.id)));
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

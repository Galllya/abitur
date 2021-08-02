import 'package:abitur/data/favotites_repository.dart';
import 'package:abitur/favorites_page/bloc/favorites_bloc.dart';
import 'package:abitur/favorites_page/view/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesBloc favoritesBloc;

  @override
  void initState() {
    super.initState();
    favoritesBloc = FavoritesBloc(
      favoritesRepository: context.read<FavoritesRepository>(),
    )..add(FavoritesLoaded());
  }

  @override
  void dispose() {
    favoritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
        centerTitle: true,
      ),
      body: Favorites(),
    );
  }
}

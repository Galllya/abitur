part of 'favorites_bloc.dart';

@immutable
class FavoritesState {
  final bool loading;
  final List<FavoritesDate> favorites;

  const FavoritesState({
    this.loading = false,
    this.favorites = const [],
  });

  FavoritesState copyWith({
    bool? loading,
    List<FavoritesDate>? favorites,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      loading: loading ?? this.loading,
    );
  }
}

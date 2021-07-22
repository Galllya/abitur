part of 'initialization_bloc.dart';

@immutable
class InitializationState {
  final bool? isLogged;
  const InitializationState({this.isLogged = null});
  InitializationState copyWith({
    bool? isLogged,
  }) {
    return InitializationState(
      isLogged: isLogged ?? this.isLogged,
    );
  }
}

import 'dart:async';

import 'package:abitur/data/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final IAccountRepository accountRepository;
  AuthorizationBloc({required this.accountRepository})
      : super(AuthorizationState());

  @override
  Stream<AuthorizationState> mapEventToState(
    AuthorizationEvent event,
  ) async* {
    if (event is LoginStarted) {
      yield* _mapAuthorizationListSLoadedToState(event);
    }
  }

  Stream<AuthorizationState> _mapAuthorizationListSLoadedToState(
      LoginStarted loginStarted) async* {
    accountRepository.authorize(loginStarted.login, loginStarted.password);
  }
}

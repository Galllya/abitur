import 'dart:async';

import 'package:abitur/common/network/errors/error_model.dart';
import 'package:abitur/data/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      yield* _mapAuthorizationSLoadedToState(event);
    }
  }

  Stream<AuthorizationState> _mapAuthorizationSLoadedToState(
      LoginStarted loginStarted) async* {
    try {
      yield state.copyWith(
        formIsSent: true,
      );
      await accountRepository.authorize(loginStarted.logAndPas);
      yield state.copyWith(
        successfulAuthorization: true,
      );
    } on DioError catch (e) {
      print(ErrorModel.fromJson(e.response!.data).commonErrors);
      yield state.copyWith(
        textError: ErrorModel.fromJson(e.response!.data).commonErrors,
      );
    }
    yield state.copyWith(
      formIsSent: false,
    );
  }
}

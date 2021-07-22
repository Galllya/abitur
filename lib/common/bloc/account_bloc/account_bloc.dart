import 'dart:async';

import 'package:abitur/domain/account.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final SharedPreferences sharedPreferences;
  AccountBloc(this.sharedPreferences) : super(AccountState());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is LoadingProfileData) {
      yield* _mapAccountStateListLoadingProfileDate();
    } else if (event is LogOutOfProfile) {
      yield* _mapAccountStateListLogOutOfProfile();
    }
  }

  Stream<AccountState> _mapAccountStateListLoadingProfileDate() async* {}

  Stream<AccountState> _mapAccountStateListLogOutOfProfile() async* {
    sharedPreferences.clear();
  }
}

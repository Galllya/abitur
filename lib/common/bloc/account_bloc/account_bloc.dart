import 'dart:async';

import 'package:abitur/data/account_repository.dart';
import 'package:abitur/domain/account.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final SharedPreferences sharedPreferences;
  final IAccountRepository accountRepository;
  AccountBloc(this.sharedPreferences, this.accountRepository)
      : super(AccountState());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is LoadingProfileData) {
      yield* _mapAccountStateLoadingProfileDate();
    } else if (event is LogOutOfProfile) {
      yield* _mapAccountStateLogOutOfProfile();
    }
  }

  Stream<AccountState> _mapAccountStateLoadingProfileDate() async* {
    try {
      final account = await accountRepository.loadAccount();
      state.copyWith(
        accountData: account,
        isLoading: true,
      );
    } catch (e) {}
  }

  Stream<AccountState> _mapAccountStateLogOutOfProfile() async* {
    sharedPreferences.clear();
  }
}

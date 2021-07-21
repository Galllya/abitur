import 'package:abitur/domain/account.dart';
import 'package:abitur/domain/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_provider.dart';

abstract class IAccountRepository {
  final AccountProvider accountProvider;
  final SharedPreferences sharedPreferences;

  IAccountRepository(this.accountProvider, this.sharedPreferences);

  Future<AccountData> loadAccount();
  Future<TokenData> authorize(String email, String password);
}

class AccountRepository extends IAccountRepository {
  AccountRepository(
      AccountProvider accountProvider, SharedPreferences sharedPreferences)
      : super(accountProvider, sharedPreferences);

  @override
  Future<AccountData> loadAccount() {
    return accountProvider.loadAccount();
  }

  @override
  Future<TokenData> authorize(String email, String password) {
    return accountProvider.authorize();
  }
}

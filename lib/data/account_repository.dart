import 'package:abitur/domain/account.dart';
import 'package:abitur/domain/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_provider.dart';

abstract class IAccountRepository {
  final AccountProvider accountProvider;
  final SharedPreferences sharedPreferences;

  IAccountRepository(this.accountProvider, this.sharedPreferences);

  Future<AccountData> loadAccount();
  Future<TokenData> authorize(Map<String, dynamic> form);
  Future<AccountData> putSubjects(subjectInAccount);
}

class AccountRepository extends IAccountRepository {
  AccountRepository(
      AccountProvider accountProvider, SharedPreferences sharedPreferences)
      : super(accountProvider, sharedPreferences);

  @override
  Future<AccountData> loadAccount() async {
    return accountProvider.loadAccount();
  }

  @override
  Future<TokenData> authorize(Map<String, dynamic> form) async {
    try {
      final res = await accountProvider.authorize(form);
      sharedPreferences.setString('token', res.token);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AccountData> putSubjects(subjectInAccount) async {
    return putSubjects(subjectInAccount);
  }
}

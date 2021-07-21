import 'package:abitur/common/network/application_rest_client.dart';
import 'package:abitur/data/rest_client_provider.dart';
import 'package:abitur/domain/account.dart';
import 'package:abitur/domain/token.dart';

class AccountProvider extends RestClientProvider {
  AccountProvider(ApplicationRestClient applicationRestClient)
      : super(applicationRestClient);

  Future<AccountData> loadAccount() async {
    return applicationRestClient.loadAccount();
  }

  Future<TokenData> authorize(String email, String password) async {
    return applicationRestClient.loadToken();
  }
}

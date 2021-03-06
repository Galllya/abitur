import 'package:abitur/common/network/application_rest_client.dart';
import 'package:abitur/data/rest_client_provider.dart';
import 'package:abitur/domain/account.dart';
import 'package:abitur/domain/subject_in_accoint.dart';
import 'package:abitur/domain/token.dart';
import 'package:abitur/domain/transfer_login_and_password.dart';

class AccountProvider extends RestClientProvider {
  AccountProvider(ApplicationRestClient applicationRestClient)
      : super(applicationRestClient);

  Future<AccountData> loadAccount() async {
    return applicationRestClient.loadAccount();
  }

  Future<TokenData> authorize(Map<String, dynamic> form) async {
    return applicationRestClient.authorize(
        loginPasswordModel: LoginPasswordModel.fromJson(form));
  }

  Future<void> putSubjects(Map<String, dynamic> form) async {
    return applicationRestClient.putSubjects(
      List<SubjectInAccount>.from(
        (form['subjects'] as List<dynamic>).map(
          (e) => SubjectInAccount.fromJson(e),
        ),
      ),
    );
  }
}

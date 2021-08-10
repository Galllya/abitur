import 'package:abitur/common/network/application_rest_client.dart';
import 'package:abitur/data/rest_client_provider.dart';
import 'package:abitur/domain/subjects.dart';

class SubjectsProvider extends RestClientProvider {
  SubjectsProvider(ApplicationRestClient applicationRestClient)
      : super(applicationRestClient);

  Future<List<SubjectsDate>> loadSubjects() async {
    return applicationRestClient.loadSubjects();
  }
}

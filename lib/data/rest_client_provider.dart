import 'package:abitur/common/data/provider.dart';
import 'package:abitur/common/network/application_rest_client.dart';

abstract class RestClientProvider extends IProvider {
  final ApplicationRestClient applicationRestClient;
  RestClientProvider(this.applicationRestClient);
}

import 'package:dio/dio.dart';

abstract class IProvider {
  const IProvider();
}

abstract class DioProvider extends IProvider {
  final Dio dio;

  const DioProvider(this.dio);
}

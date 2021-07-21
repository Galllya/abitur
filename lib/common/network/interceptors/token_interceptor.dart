import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  final SharedPreferences sharedPreferences;
  final Dio dio;

  TokenInterceptor(this.sharedPreferences, this.dio);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (sharedPreferences.containsKey('token')) {
      dio.lock();
      final newOptions = options.copyWith(headers: {
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
      });
      super.onRequest(newOptions, handler);
      dio.unlock();
    } else {
      super.onRequest(options, handler);
    }
  }
}

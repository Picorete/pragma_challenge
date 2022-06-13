import 'package:dio/dio.dart';

class XApiKeyInterceptor extends Interceptor {
  XApiKeyInterceptor();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(
        <String, String>{'x-api-key': 'bda53789-d59e-46cd-9bc4-2936630fde39'});

    super.onRequest(options, handler);
  }
}

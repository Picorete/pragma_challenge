import 'package:dio/dio.dart';

import '../interceptors/XApiKeyInterceptor.dart';
import '../interceptors/accept_header_interceptor.dart';

class RemoteDataSource {
  final Dio _http = Dio(
    BaseOptions(
      baseUrl: 'https://api.thecatapi.com/v1',
    ),
  )
    ..interceptors.add(AcceptHeaderInterceptor())
    ..interceptors.add(XApiKeyInterceptor());

  static final RemoteDataSource _singleton = RemoteDataSource._internal();

  factory RemoteDataSource() {
    return _singleton;
  }

  RemoteDataSource._internal();

  Future<Response> getCats() async {
    return _http.get('/breeds');
  }
}

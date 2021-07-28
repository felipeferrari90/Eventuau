import 'package:dio/dio.dart';
class ServiceConfig {

  String _endPoint = "";
  int timeout = 5000;

  ServiceConfig(this._endPoint, {this.timeout = 5000} );
  Dio create() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        baseUrl: _endPoint,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions request) async {
          //request.headers["token"] = "sa09f0dfkjfkashd";
          return request;
        },
        onResponse: (Response response) async {
          return response;
        },
        onError: (DioError error) async {
          return error;
        },
      ),
    );

    return dio;
  }
}

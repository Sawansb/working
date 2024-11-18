import 'package:dio/dio.dart';
import 'package:working/Api%20Services/error_handler.dart';

class HttpService {
  final Dio _dio = Dio();

  HttpService() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com/";
    _dio.options.headers = {
      'content-type': 'application/json',
    };
  }

  Dio get httpService => _dio;

  // POST method
  Future<Response> post(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(
        '/posts',
        data: data,
      );
      return response;
    } catch (error, stacktrace) {
      final exception = handleError(error);
      print("Exception occurred: $exception stackTrace: $stacktrace");
      throw exception;
    }
  }

  // GET method
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } catch (error, stacktrace) {
      final exception = handleError(error);
      print("Exception occurred: $exception stackTrace: $stacktrace");
      throw exception;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:working/Api%20Services/http-services.dart';

class PostDetailsRepository {
  final HttpService _httpService = HttpService();

  Future<Response> fetchPostDetails(int postId) async {
    return await _httpService.get('/posts/$postId');
  }
}

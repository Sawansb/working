import 'package:dio/dio.dart';
import 'package:working/Api%20Services/http-services.dart';

class PostRepository {
  final HttpService _httpService = HttpService();

  Future<Response> fetchPosts() async {
    return await _httpService.get('/posts');
  }

  Future<Response> createPost(Map<String, dynamic> postData) async {
    return await _httpService.post(postData);
  }
}

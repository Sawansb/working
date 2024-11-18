import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final Map<String, dynamic> postData;

  CreatePost(this.postData);

  @override
  List<Object?> get props => [postData];
}

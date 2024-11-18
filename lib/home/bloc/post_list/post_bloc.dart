import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working/home/bloc/post_list/post_events.dart';
import 'package:working/home/bloc/post_list/post_states.dart';
import 'package:working/home/model/post_model.dart';
import 'package:working/home/repo/post%20list/post_repo.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _repository;

  PostBloc(this._repository) : super(PostInitial()) {
    // Handle FetchPosts Event
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final response = await _repository.fetchPosts();
        // Convert response data into a list of Post objects
        List<Post> posts = postListFromJson(response.data);
        emit(PostLoaded(posts)); // Pass the list of posts
      } catch (error) {
        emit(PostError(error.toString()));
      }
    });

    // Handle CreatePost Event
    on<CreatePost>((event, emit) async {
      emit(PostLoading());
      try {
        final response = await _repository.createPost(event.postData);
        // Assuming the created post is returned as a single object
        Post newPost = Post.fromJson(response.data);
        emit(PostLoaded([newPost])); // Show the newly created post
      } catch (error) {
        emit(PostError(error.toString()));
      }
    });
  }
}

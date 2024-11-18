import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working/home/bloc/post_events.dart';
import 'package:working/home/bloc/post_states.dart';
import 'package:working/home/repo/post_repo.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _repository;

  PostBloc(this._repository) : super(PostInitial()) {
    // Handle FetchPosts Event
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final response = await _repository.fetchPosts();
        emit(PostLoaded(
            response.data)); // Assuming response.data is a list of posts
      } catch (error) {
        emit(PostError(error.toString()));
      }
    });

    // Handle CreatePost Event
    on<CreatePost>((event, emit) async {
      emit(PostLoading());
      try {
        final response = await _repository.createPost(event.postData);
        emit(PostLoaded([response.data])); // Show the newly created post
      } catch (error) {
        emit(PostError(error.toString()));
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working/home/bloc/post_details/post_detail_events.dart';
import 'package:working/home/bloc/post_details/post_detail_states.dart';
import 'package:working/home/model/post_model.dart';
import 'package:working/home/repo/post%20detail/post_detail_repo.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final PostDetailsRepository repository;

  PostDetailsBloc(this.repository) : super(PostDetailsInitial()) {
    on<FetchPostDetails>((event, emit) async {
      emit(PostDetailsLoading());
      try {
        final response = await repository.fetchPostDetails(event.postId);

        final post = Post.fromJson(response.data);
        emit(PostDetailsLoaded(post));
      } catch (e) {
        emit(PostDetailsError(e.toString()));
      }
    });
  }
}

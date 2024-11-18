// post_details_states.dart
import 'package:working/home/model/post_model.dart';

abstract class PostDetailsState {}

class PostDetailsInitial extends PostDetailsState {}

class PostDetailsLoading extends PostDetailsState {}

class PostDetailsLoaded extends PostDetailsState {
  final Post post;

  PostDetailsLoaded(this.post);
}

class PostDetailsError extends PostDetailsState {
  final String message;

  PostDetailsError(this.message);
}

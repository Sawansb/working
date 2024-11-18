// post_details_events.dart
abstract class PostDetailsEvent {}

class FetchPostDetails extends PostDetailsEvent {
  final int postId;

  FetchPostDetails(this.postId);
}

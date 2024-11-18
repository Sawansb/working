import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working/home/bloc/post_details/post_detail_bloc.dart';
import 'package:working/home/bloc/post_details/post_detail_events.dart';
import 'package:working/home/bloc/post_details/post_detail_states.dart';
import 'package:working/home/repo/post%20detail/post_detail_repo.dart';

class DetailsScreen extends StatelessWidget {
  final int postId;

  const DetailsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostDetailsBloc(PostDetailsRepository())
        ..add(FetchPostDetails(postId)),
      child: const PostDetailsView(),
    );
  }
}

class PostDetailsView extends StatelessWidget {
  const PostDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: BlocBuilder<PostDetailsBloc, PostDetailsState>(
        builder: (context, state) {
          if (state is PostDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostDetailsLoaded) {
            final postDetails = state.post;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postDetails.title,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    postDetails.body,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            );
          } else if (state is PostDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Unexpected State'));
        },
      ),
    );
  }
}

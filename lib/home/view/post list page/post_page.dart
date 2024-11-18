import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working/home/bloc/post_list/post_bloc.dart';
import 'package:working/home/bloc/post_list/post_events.dart';
import 'package:working/home/bloc/post_list/post_states.dart';
import 'package:working/home/repo/post%20list/post_repo.dart';
import 'dart:async'; // For Timer
import 'dart:math'; // For generating random numbers
import 'package:visibility_detector/visibility_detector.dart';
import 'package:working/home/view/post%20detail%20page/post_detail_page.dart'; // For tracking visibility

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(PostRepository())..add(FetchPosts()),
      child: const PostView(),
    );
  }
}

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  // Function to generate a random timer duration (10, 20, or 25 seconds)
  int generateRandomTimer() {
    final random = Random();
    return [10, 20, 25][random.nextInt(3)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                final randomDuration = generateRandomTimer();
                post.timerDuration =
                    randomDuration; // Store the random duration

                // Start the timer when the post is visible
                return VisibilityDetector(
                  key: Key(post.id.toString()),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction > 0) {
                      post.startTimer(); // Start or resume the timer when visible
                    } else {
                      post.pauseTimer(); // Pause the timer when not visible
                    }
                  },
                  child: Card(
                    color: post.isRead ? Colors.grey[300] : Colors.yellow[100],
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                      onTap: () {
                        setState(() {
                          post.isRead = true; // Mark the post as read
                        });

                        // Navigate to the Details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(postId: post.id),
                          ),
                        );
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer, color: Colors.orange),
                          const SizedBox(width: 5),
                          StreamBuilder<int>(
                            stream: post.timerStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              final elapsedTime = snapshot.data ?? 0;
                              final remainingTime =
                                  post.timerDuration - elapsedTime;
                              return Text('$remainingTime s',
                                  style: TextStyle(color: Colors.black));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No posts available.'));
        },
      ),
    );
  }
}

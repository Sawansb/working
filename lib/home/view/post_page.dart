import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working/home/bloc/post_bloc.dart';
import 'package:working/home/bloc/post_events.dart';
import 'package:working/home/bloc/post_states.dart';
import 'package:working/home/repo/post_repo.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(PostRepository()),
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
  @override
  void initState() {
    final postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(FetchPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostLoaded) {
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return Card(
                        color: Colors.yellow[100], // Light yellow background
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['title'] ?? 'No Title',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                post['content'] ?? 'No Content',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is PostError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(
                    child: Text('Press the button to fetch posts.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

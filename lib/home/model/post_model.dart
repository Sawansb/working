import 'dart:async';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  bool isRead; // Add isRead property
  int timerDuration; // Random timer duration (in seconds)
  late Timer _timer; // Timer to handle countdown
  int _elapsedTime = 0; // Time elapsed in seconds
  final _timerStreamController =
      StreamController<int>.broadcast(); // Stream controller for timer updates

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false, // Default value is false (not read)
    required this.timerDuration, // Timer duration for each post
  });

  // Factory constructor to create a Post from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isRead: json['isRead'] ?? false, // Handle isRead if it exists
      timerDuration:
          json['timerDuration'] ?? 0, // Handle the timerDuration from the JSON
    );
  }

  // Method to convert a Post object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead, // Include isRead in JSON
      'timerDuration': timerDuration, // Include timerDuration in JSON
    };
  }

  // Start the timer for the post
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedTime++;
      _timerStreamController.add(_elapsedTime); // Emit elapsed time
      if (_elapsedTime >= timerDuration) {
        _timer.cancel(); // Stop the timer after reaching the duration
      }
    });
  }

  // Pause the timer
  void pauseTimer() {
    _timer.cancel(); // Stop the timer if paused
  }

  // Reset the timer
  void resetTimer() {
    _elapsedTime = 0;
  }

  // Get the time remaining in seconds
  int get remainingTime => timerDuration - _elapsedTime;

  // Check if the timer is finished
  bool get isTimerFinished => _elapsedTime >= timerDuration;

  // Stream to listen to timer updates
  Stream<int> get timerStream => _timerStreamController.stream;

  // Close the stream when the post is disposed
  void dispose() {
    _timerStreamController.close();
  }
}

// Helper function to parse a list of posts from JSON
List<Post> postListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => Post.fromJson(json)).toList();
}

// Helper function to convert a list of posts to JSON
List<Map<String, dynamic>> postListToJson(List<Post> posts) {
  return posts.map((post) => post.toJson()).toList();
}

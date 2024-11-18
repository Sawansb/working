// Model for the JSON response
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor to create a Post from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Method to convert a Post object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
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

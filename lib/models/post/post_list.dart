import 'dart:convert'; // jsonDecode를 사용하기 위해 import

// post list model
class PostList {
  final int id;
  final int user;
  final String title;
  final String content;
  final String image_url;
  final int sdgs;
  final int likes;
  final String created_at;

  const PostList({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.image_url,
    required this.sdgs,
    required this.likes,
    required this.created_at,
  });
}

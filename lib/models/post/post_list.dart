import 'dart:convert'; // jsonDecode를 사용하기 위해 import

// post list model
class PostList {
  final int id;
  final int user;
  final String user_name;
  final String user_profile_img;
  final String title;
  final String content;
  final int sdgs;
  final int likes;
  final String created_at;

  const PostList({
    required this.id,
    required this.user,
    required this.user_name,
    required this.user_profile_img,
    required this.title,
    required this.content,
    required this.sdgs,
    required this.likes,
    required this.created_at,
  });

  factory PostList.fromJson(Map<String, dynamic> json) {
    return PostList(
      id: json['id'],
      user: json['user'],
      user_name: json['user_name'],
      user_profile_img: json['user_profile_img'],
      title: json['title'],
      content: json['content'],
      sdgs: json['sdgs'],
      likes: json['likes'],
      created_at: json['created_at'],
    );
  }
}

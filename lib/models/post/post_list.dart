import 'dart:convert'; // jsonDecode를 사용하기 위해 import

// post list model
class PostList {
  final int id;
  final User user;
  final String title;
  final String content;
  final int sdgs;
  final int likes;
  final String created_at;

  const PostList({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.sdgs,
    required this.likes,
    required this.created_at,
  });

  factory PostList.fromJson(Map<String, dynamic> json) {
    return PostList(
      id: json['id'],
      user: User.fromJson(json['user']),
      title: json['title'],
      content: json['content'],
      sdgs: json['sdgs'],
      likes: json['likes'],
      created_at: json['created_at'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String profile_img;

  User({
    required this.id,
    required this.name,
    required this.profile_img,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profile_img: json['profile_img'],
    );
  }
}
import 'dart:convert'; // jsonDecode를 사용하기 위해 import

class Comment {
  final int id;
  final User user;
  final String content;
  final int? parentFeedback;
  final String createdAt;

  const Comment({
    required this.id,
    required this.user,
    required this.content,
    this.parentFeedback,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: User.fromJson(json['user']),
      content: json['content'],
      parentFeedback: json['parent_feedback'],
      createdAt: json['created_at'],
    );
  }

  // comment 객체를 list로 변환한다.
  static List<Comment> parseComments(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
  }
}


class User {
  final int id;
  final String? name;
  final String? profileImg;

  User({
    required this.id,
    this.name,
    this.profileImg,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profileImg: json['profile_img'],
    );
  }
}
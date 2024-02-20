import 'dart:convert'; // jsonDecode를 사용하기 위해 import

class Comment {
  final int id;
  final int user_id;
  final String user_name;
  final String user;
  final String content;
  final String creadted_at;
  final int post;
  final int parent_feedback;

  const Comment({
    required this.id,
    required this.user_id,
    required this.user_name,
    required this.user,
    required this.content,
    required this.creadted_at,
    required this.post,
    required this.parent_feedback,
  });

  // JSON 데이터를 Comment 객체로 변환하는 팩토리 메서드
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user_id: json['user'],
      user_name: json['user_name'],
      user: json['user'],
      content: json['content'],
      creadted_at: json['created_at'],
      post: json['post'],
      parent_feedback: json['parent_feedback'],
    );
  }
}

// JSON 데이터를 받아서 Comment 객체로 변환하는 함수
Comment parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return Comment.fromJson(parsed);
}
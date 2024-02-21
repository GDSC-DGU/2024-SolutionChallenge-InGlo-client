import 'dart:convert'; // jsonDecode를 사용하기 위해 import

class User {
  final int? id;
  final String? email;
  final String? name;
  final String? profile_img;
  final int? country;
  final String? language;
  final int? liked_total;
  final int? sketch_num;
  final int? feedback_total;
  final int? post_total;
  final double? global_impact;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.profile_img,
    required this.country,
    required this.language,
    required this.liked_total,
    required this.sketch_num,
    required this.feedback_total,
    required this.post_total,
    required this.global_impact,
  });

  // JSON 데이터를 User 객체로 변환하는 팩토리 메서드
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profile_img: json['profile_img'],
      country: json['country'],
      language: json['language'],
      liked_total: json['liked_total'],
      sketch_num: json['sketch_num'],
      feedback_total: json['feedback_total'],
      post_total: json['post_total'],
      global_impact: json['global_impact'],
    );
  }
}

// JSON 데이터를 받아서 User 객체로 변환하는 함수
User parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return User.fromJson(parsed);
}
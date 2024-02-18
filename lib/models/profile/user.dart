// 유저 정보 조회

class User {
  final int id;
  final String email;
  final String name;
  final String profile_img;
  final int country;
  final String language;
  final int liked_total;
  final int sketch_num;
  final int feedback_total;
  final int percent;
  final String created_at;

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
    required this.percent,
    required this.created_at,
  });
}
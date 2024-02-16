// 스케치 리스트 조회
class SektchList {
  final int id;
  final String title;
  final String description;
  final String content;
  final String image_url;
  final String created_at;
  final int user;
  final int problem;
  final int hmw;
  final int crazy8stack;

  const SektchList({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.image_url,
    required this.created_at,
    required this.user,
    required this.problem,
    required this.hmw,
    required this.crazy8stack,
  });
}
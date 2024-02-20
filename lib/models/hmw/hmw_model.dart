class HMWModel {
  int id;
  String content;
  String createdAt;
  int problem;

  HMWModel(
      {required this.id,
      required this.content,
      required this.createdAt,
      required this.problem});

  HMWModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        createdAt = json['created_at'],
        problem = json['problem'];
}

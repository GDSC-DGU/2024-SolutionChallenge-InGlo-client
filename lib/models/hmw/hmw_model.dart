class HMWModel {
  int id;
  int problem;
  String problemContent;
  String content;
  String createdAt;


  HMWModel(
      {required this.id,
        required this.problemContent,
      required this.content,
      required this.createdAt,
      required this.problem});

  HMWModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        problemContent = json['problem_content'] ?? "",
        content = json['content'] ?? "",
        createdAt = json['created_at'] ?? "",
        problem = json['problem'];
}

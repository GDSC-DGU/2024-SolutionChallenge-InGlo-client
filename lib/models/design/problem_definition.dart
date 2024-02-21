class ProblemDefinitionModel {
  int id;
  String content;
  int sdgs;
  String createdAt;

  ProblemDefinitionModel({required this.id, required this.content, required this.sdgs, required this.createdAt});

  ProblemDefinitionModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
    content = json['content'],
    sdgs = json['sdgs'],
    createdAt = json['created_at'];

}
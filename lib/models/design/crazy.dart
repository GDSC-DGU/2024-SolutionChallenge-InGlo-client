class CrazyMineModel {
  String hmwContent;
  List crazy8stack;

  CrazyMineModel({required this.hmwContent, required this.crazy8stack});

  CrazyMineModel.fromJson(Map<String, dynamic> json)
    : hmwContent = json['hmw_content'] ?? "",
      crazy8stack = json['crazy8stack'] ?? [];
}

class CrazyAllModel {
  int id;
  List contents;
  String createdAt;
  int problem;

  CrazyAllModel({required this.id, required this.contents, required this.createdAt, required this.problem});

  CrazyAllModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? 0,
      contents = json['contents'] ?? [],
      createdAt = json['created_at'] ?? "",
      problem = json['problem'] ?? 0;
}
class CrazyMineModel {
  String hmwContent;
  List crazy8stack;

  CrazyMineModel({required this.hmwContent, required this.crazy8stack});

  CrazyMineModel.fromJson(Map<String, dynamic> json)
    : hmwContent = json['hmw_content'] ?? "",
      crazy8stack = json['crazy8stack'] ?? [];
}

class CrazyAllModel {
  List contents;
  String createdAt;

  CrazyAllModel({required this.contents, required this.createdAt});

  CrazyAllModel.fromJson(Map<String, dynamic> json)
      : contents = json['contents'] ?? [],
      createdAt = json['created_at'] ?? "";
}
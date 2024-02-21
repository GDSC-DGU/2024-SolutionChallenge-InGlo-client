class MyDrawingListModel {
  int id;
  String title;
  String description;
  String content;
  String imageUrl;
  String createdAt;
  String user;
  String problem;
  String hmw;
  List crazy8stack;

  MyDrawingListModel(
      {required this.id,
        required this.title,
        required this.description,
        required this.content,
        required this.imageUrl,
        required this.createdAt,
        required this.user,
        required this.problem,
        required this.hmw,
        required this.crazy8stack});

  MyDrawingListModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? 0,
    title = json['title'] ?? "",
    description = json['description'] ?? "",
    content = json['content'] ?? "",
    imageUrl = json['image_url'] ?? "",
    createdAt = json['created_at'] ?? "",
    user = json['user'] ?? "",
    problem = json['problem'] ?? "",
    hmw = json['hmw'] ?? "",
    crazy8stack = json['crazy8stack'] ?? [];
}

class MyDrawingDetailModel {
  int id;
  String user;
  String title;
  String description;
  String content;
  String imageUrl;
  String createdAt;
  String problem;
  String hmw;
  List crazy8stack;

  MyDrawingDetailModel(
      {required this.id,
        required this.user,
        required this.title,
        required this.description,
        required this.content,
        required this.imageUrl,
        required this.createdAt,
        required this.problem,
        required this.hmw,
        required this.crazy8stack});

  MyDrawingDetailModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
    user = json['user'] ?? "",
    title = json['title'] ?? "",
    description = json['description'] ?? "",
    content = json['content'] ?? "",
    imageUrl = json['image_url'] ?? "",
    createdAt = json['created_at'] ?? "",
    problem = json['problem'] ?? "",
    hmw = json['hmw'] ?? "",
    crazy8stack = json['crazy8stack'] ?? [];
}

class IssueDetailModel {
  int id;
  List comments;
  bool userHasLiked;
  String link;
  String writer;
  String title;
  String content;
  String imageUrl;
  String createdAt;

  IssueDetailModel(
      {required this.id,
        required this.comments,
        required this.userHasLiked,
        required this.link,
        required this.writer,
        required this.title,
        required this.content,
        required this.imageUrl,
        required this.createdAt});

  IssueDetailModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
    comments = json['comments'],
    userHasLiked = json['user_has_liked'],
    link = json['link'] ?? "",
    writer = json['writer'] ?? "",
    title = json['title'] ?? "",
    content = json['content'] ?? "",
    imageUrl = json['image_url'] ?? "",
    createdAt = json['created_at'] ?? "";

}
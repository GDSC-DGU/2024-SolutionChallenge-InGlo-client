import 'dart:convert'; // JSON 디코드를 위해 필요

class DetailPost {
  final int id;
  final int user;
  final Sketch sketch; // detail sketch
  final String title;
  final String content;
  final int sdgs;
  final int likes;
  final String created_at;
  final List<dynamic> feedbacks;
  final bool is_liked;

  const DetailPost({
    required this.id,
    required this.user,
    required this.sketch,
    required this.title,
    required this.content,
    required this.sdgs,
    required this.likes,
    required this.created_at,
    required this.feedbacks,
    required this.is_liked,
  });

  // 데이터 입력
  factory DetailPost.fromJson(Map<String, dynamic> json) {
    return DetailPost(
      id: json['id'],
      user: json['user'],
      sketch: Sketch.fromJson(json['sketch']),
      title: json['title'],
      content: json['content'],
      sdgs: json['sdgs'],
      likes: json['likes'],
      created_at: json['created_at'],
      feedbacks: json['feedbacks'],
      is_liked: json['is_liked'],
    );
  }
}

class Sketch {
  final int id;
  final String user;
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String createdAt;
  final String problem;
  final String hmw;
  final List<Crazy8> crazy8stack;

  Sketch({
    required this.id,
    required this.user,
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.problem,
    required this.hmw,
    required this.crazy8stack,
  });

  factory Sketch.fromJson(Map<String, dynamic> json) {
    return Sketch(
      id: json['id'],
      user: json['user'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      problem: json['problem'],
      hmw: json['hmw'],
      crazy8stack: List<Crazy8>.from(json['crazy8stack'].map((x) => Crazy8.fromJson(x))),
    );
  }
}

class Crazy8 {
  final String content;

  Crazy8({required this.content});

  factory Crazy8.fromJson(Map<String, dynamic> json) {
    return Crazy8(
      content: json['content'],
    );
  }
}
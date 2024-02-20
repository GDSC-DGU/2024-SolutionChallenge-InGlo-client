import 'dart:convert'; // JSON 디코드를 위해 필요

class DetailPost {
  final int id;
  final int user;
  final DetailSketch sketch; // detail sketch
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
      sketch: DetailSketch.fromJson(json['sketch']),
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

class DetailSketch {
  final int id;
  final String user;
  final String title;
  final String image_url;
  final String created_at;
  final String problem;
  final String hmw;
  final List<CrazyItem> crazy8stck;

  const DetailSketch({
    required this.id,
    required this.user,
    required this.title,
    required this.image_url,
    required this.created_at,
    required this.problem,
    required this.hmw,
    required this.crazy8stck,
  });

  factory DetailSketch.fromJson(Map<String, dynamic> json) {
    var crazy8stckList = (json['crazy8stck'] as List)
        .map((item) => CrazyItem.fromJson(item as Map<String, dynamic>))
        .toList();

    return DetailSketch(
      id: json['id'],
      user: json['user'],
      title: json['title'],
      image_url: json['image_url'],
      created_at: json['created_at'],
      problem: json['problem'],
      hmw: json['hmw'],
      crazy8stck: crazy8stckList,
    );
  }
}

class CrazyItem {
  final String content;

  const CrazyItem({
    required this.content,
  });

  factory CrazyItem.fromJson(Map<String, dynamic> json) {
    return CrazyItem(
      content: json['content'],
    );
  }
}

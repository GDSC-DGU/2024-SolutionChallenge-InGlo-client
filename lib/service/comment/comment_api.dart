import 'package:dio/dio.dart';

class CommentService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // feedback 받아오기
  Future<void> getFeedbacks(String postId) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer YOUR_TOKEN',
          },
        ),
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        print('성공!');
        // 여기에서 응답 데이터를 처리합니다.
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // feedback 전송하기
  Future<void> postFeedback(String postId, String content, String? parentId) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/";

    Map<String, dynamic> data = {
      "content": content,
      "parent_id": parentId,
    };

    try {
      final response = await dio.patch(url, data: data, options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          "Authorization": 'Bearer YOUR_TOKEN',
        },
      ));

      if (response.statusCode == 200) {
        print('Success code: ${response.statusCode}, response: ${response.data}');
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
}

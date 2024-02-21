import 'package:dio/dio.dart';

class PostService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // post 수정 api
  Future<void> ModifiedPost(String _title, String _content, int post_id, String _token) async {
    final url = "https://dongkyeom.com/api/v1/posts/${post_id}";
    Map<String, dynamic> data = {
      "title": _title,
      "content": _content,
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
        'Bearer $_token',
      },
    );

    try {
      final response = await dio.patch(url, data: data, options: options);

      if (response.statusCode == 200) {
        // 성공
        print(
            'Success code: ${response.statusCode}, response: ${response.data}');
      } else {
        // 비-200 상태 코드
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }
  }

  // post 삭제 api
  Future<void> deletePost(int postId, String _token) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId";

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
        'Bearer $_token',
      },
    );

    try {
      final response = await dio.delete(url, options: options);

      if (response.statusCode == 200) {
        // 성공
        print(
            'Success code: ${response.statusCode}, response: ${response.data}');
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
}

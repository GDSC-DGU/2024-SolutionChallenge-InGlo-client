import 'package:dio/dio.dart';

class PostService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // post 수정 api
  Future<void> ModifiedPost(String _title, String _content, int post_id) async {
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
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4MzY4MTQ3LCJpYXQiOjE3MDgzNjQ1NDcsImp0aSI6IjYyNzRjY2RjZjY1MzQ4NjU5NjYzOTQxZjVmMDMwNDc2IiwidXNlcl9pZCI6M30._-R-VopbH5kIv9YkbMGuARcOF9z4E2TwQiy0kq-d6Uw',
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
  Future<void> deletePost(int post_id) async {
    final url = "https://dongkyeom.com/api/v1/posts/${post_id}";

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4MzY4MTQ3LCJpYXQiOjE3MDgzNjQ1NDcsImp0aSI6IjYyNzRjY2RjZjY1MzQ4NjU5NjYzOTQxZjVmMDMwNDc2IiwidXNlcl9pZCI6M30._-R-VopbH5kIv9YkbMGuARcOF9z4E2TwQiy0kq-d6Uw',
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

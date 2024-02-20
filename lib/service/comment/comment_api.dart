import 'package:dio/dio.dart';

class CommentService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // feedback 받아오기
  Future<void> getFeedbacks(int postId) async {
    print('get id : $postId');
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NTk1OTg4LCJpYXQiOjE3MDg0NTE5ODgsImp0aSI6IjIzZWZjNDQ1NmJkMDRhYTI5NTQ0OTc0MGFiNmIyMjljIiwidXNlcl9pZCI6NH0.JS6_zrhwAFH0OX9HjfRkV0CGJ8BADmKXmB3r4Gf2y7E',
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
  Future<void> postFeedback(int postId, String content, int? parentId) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/";

    Map<String, dynamic> data = {
      "content": content,
      "parent_id": parentId,
    };

    try {
      final response = await dio.patch(url, data: data, options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          "Authorization": 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NTk1OTg4LCJpYXQiOjE3MDg0NTE5ODgsImp0aSI6IjIzZWZjNDQ1NmJkMDRhYTI5NTQ0OTc0MGFiNmIyMjljIiwidXNlcl9pZCI6NH0.JS6_zrhwAFH0OX9HjfRkV0CGJ8BADmKXmB3r4Gf2y7E',
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

  // 유저 정보 전송 API
  Future<void> ModifiedFeedback(String _content, int post_id, int feedback_id) async {
    final url = "https://dongkyeom.com/api/v1/posts/{post_id}/feedbacks/{feedback_id}";
    Map<String, dynamic> data = {
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

  // 유저 정보 삭제 API
  Future<void> deleteFeedback(int post_id, int feedback_id) async {
    final url = "https://dongkyeom.com/api/v1/posts/{post_id}/feedbacks/{feedback_id}";

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

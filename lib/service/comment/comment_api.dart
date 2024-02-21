import 'package:dio/dio.dart';
import 'package:inglo/models/comment/commnet.dart';

class CommentService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // feedback 받아오기
  Future<List<Comment>> getFeedbacks(int postId, String? token) async {
    print('get id : $postId');
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        print('피드백 받아오기 성공! ${response.data}');
        List<Comment> feedbacks = Comment.parseComments(response.data);

        return feedbacks;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  // feedback 전송하기
  Future<void> postFeedback(int postId, String content, int? parentId, String? token) async {
    print('post를 보냅니다. : $postId');
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/";

    Map<String, dynamic> data = {
      "content": content,
      "parent_id": parentId,
    };

    try {
      final response = await dio.post(url, data: data, options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          "Authorization": 'Bearer $token',
        },
      ));

      if (response.statusCode == 200) {
        print('Success code: ${response.statusCode}, response: ${response.data}');
        getFeedbacks(postId, token); // 다시 불러오기
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  // 피드백 수정
  Future<void> ModifiedFeedback(String _content, int postId, int? feedbackId, String? token) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/$feedbackId";
    print('post id : $postId feedback_id : $feedbackId');
    Map<String, dynamic> data = {
      "content": _content,
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
        'Bearer $token',
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
  Future<void> deleteFeedback(int postId, int? feedbackId, String? token) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId/feedbacks/$feedbackId";
    print('post id : $postId feedback_id : $feedbackId token: $token');

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
        'Bearer $token',
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

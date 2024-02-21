import 'package:dio/dio.dart';
import 'package:inglo/models/issue/comment.dart';
import 'package:inglo/models/issue/modified_comment.dart';

class IssueCommentService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // feedback 받아오기
  Future<List<IssueComment>> getComments(int issueId, String? token) async {
    print('get id : $issueId');
    final url = "https://dongkyeom.com/api/v1/issues/${issueId}/comments/";

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
        List<IssueComment> feedbacks = IssueComment.parseComments(response.data);

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
  Future<void> postComment(int issueId, String content, int? parentId, String? token) async {
    print('post를 보냅니다. : $issueId');
    final url = "https://dongkyeom.com/api/v1/issues/$issueId/comments/";

    Map<String, dynamic> data = {
      "parent_comment": parentId,
      "content": content,
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
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  // 피드백 수정
  Future<IssueModifiedComment> ModifiedComments(String _content, int issueId, int? commentId, String? token) async {
    final url = "https://dongkyeom.com/api/v1/issues/$issueId/comments/$commentId";
    print('post id : $issueId comment_id : $commentId');
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

      print(
          'Success code: ${response.statusCode}, 수정 성공!: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 성공
        IssueModifiedComment newComment = IssueModifiedComment.fromJson(response.data);
        return newComment;
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
        throw Exception('Failed to modify feedback');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Error modifying feedback');
    }
  }
  // 유저 정보 삭제 API
  Future<void> deleteComment(int issueId, int? commentId, String? token) async {
    final url = "https://dongkyeom.com/api/v1/issues/${issueId}/comments/${commentId}";
    print('post id : $issueId feedback_id : $commentId token: $token');

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

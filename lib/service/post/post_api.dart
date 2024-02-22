import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inglo/screens/postlist/post_board.dart';

class PostService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // 피드백 수정
  Future<bool> ModifiedPost(String? _title, String _content, int postId, String? token) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId";
    print('post id : $postId title : $_title content : $_content token : $token');
    Map<String, dynamic> data = {
      "title": _title,
      "content": _content,
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization": 'Bearer $token',
      },
    );

    try {
      final response = await dio.patch(url, data: data, options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success code: ${response.statusCode}, 포스트 수정 성공!: ${response
            .data}');

        return true;
        // 성공
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
        return false;
      }
    } catch (e) {
      print('Exception caught: $e');
      return false;
    }
  }

  // 유저 정보 삭제 API
  Future<void> deletePost(int postId, String? token, BuildContext context) async {
    final url = "https://dongkyeom.com/api/v1/posts/$postId";
    print('post id : $postId');

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization": 'Bearer $token',
      },
    );

    try {
      final response = await dio.delete(url, options: options);

      if (response.statusCode == 200) {
        // 성공
        print(
            'Success code: ${response.statusCode}, response: ${response.data}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PostBoardPage()),
        );
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
}

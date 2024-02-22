import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inglo/models/issue_detail/issue_detail.dart';
import 'package:inglo/models/post/post_list.dart';

class PostDetailService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // post 좋아요
  Future<void> postIssueLike(
      int postId, dynamic onClickLike, String? _token) async {
    print('postId : $postId');
    final url = "https://dongkyeom.com/api/v1/posts/$postId/like/";

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization": 'Bearer $_token',
      },
    );

    try {
      final response = await dio.post(url, options: options);

      if (response.statusCode == 201 || response.statusCode == 204) {
        print(
            'Success code: ${response.statusCode}, 포스트 종아요 성공!: ${response.data}');
        onClickLike();
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
}

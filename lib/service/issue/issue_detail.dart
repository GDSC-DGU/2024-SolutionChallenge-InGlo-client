import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inglo/models/issue_detail/issue_detail.dart';


class IssueDetailService {
  // 이슈 상세 조회
  Future<IssueDetailModel> getIssueDetail(int issueId, String? token) async {
    IssueDetailModel dataInstance;

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/issues/$issueId");

    try {
      final http.Response response = await http.get(
        coreUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
          'Bearer $token',
        },
      );

      print(response);
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(utf8.decode(response.bodyBytes)); // 글자 깨짐 문제 해결!
        dataInstance = IssueDetailModel.fromJson(data);

        //final IssueTop3Model issueTop3Model = IssueTop3Model.fromJson(data);
        //print(issueTop3Model);
        return dataInstance;
      } else {
        print(response.body);
      }
    } catch (e) {
// 예외 처리
      print('Exception caught: $e');
    }

    throw Error();
  }

  // 이슈 좋아요
  Future<void> postIssueLike(int issueId, dynamic onClickLike, String? token) async {

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/issues/$issueId/like/");
    try {
      final http.Response response = await http.post(
          coreUrl,
          headers: {
            'Accept': 'application/json',
            'Authorization':
            'Bearer $token',
          },
      );

      print("issue_detail_like: ${response.body}");
      if (response.statusCode == 201 || response.statusCode == 204) {
        onClickLike();
        print("성공");
      } else {
        print('statusCode: ${response.statusCode}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }

    throw Error();
  }
}
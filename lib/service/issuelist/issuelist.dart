import 'dart:convert';

import 'package:inglo/models/issuelist/issue_sdgs.dart';
import 'package:inglo/models/issuelist/issue_top3.dart';
import 'package:http/http.dart' as http;
import 'package:inglo/service/issue_detail/issue_detail.dart';

class IssueTop3Service {
  Future<List<IssueTop3Model>> getIssueTop3() async {
    List<IssueTop3Model> dataInstance = [];

    final coreUrl =
        Uri.parse("https://dongkyeom.com/api/v1/issues/recommended/");

    try {
      final http.Response response = await http.get(
        coreUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes)); // 글자 깨짐 문제 해결!
        for (var d in data) {
          dataInstance.add(IssueTop3Model.fromJson(d));
        }
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
}

// SDGs 카테고리별 이슈
class IssueSdgsService {
  Future<List<IssueSdgsModel>> getIssueSdgs(int sdgs) async {
    List<IssueSdgsModel> dataInstance = [];

    final coreUrl = Uri.parse("https://dongkyeom.com/api/v1/issues/sdgs/$sdgs");

    try {
      final http.Response response = await http.get(
        coreUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        // final List<dynamic> data = jsonDecode(response.body);
        for (var d in data) {
          dataInstance.add(IssueSdgsModel.fromJson(d));
        }
        //final IssueTop3Model issueTop3Model = IssueTop3Model.fromJson(data);
        //print(issueTop3Model);
        return dataInstance;
      } else {
        print(response);
      }
    } catch (e) {
// 예외 처리
      print('Exception caught: $e');
    }

    throw Error();
  }
}

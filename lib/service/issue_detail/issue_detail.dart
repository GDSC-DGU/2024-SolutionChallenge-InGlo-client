import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inglo/models/issue_detail/issue_detail.dart';

const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NDAyNTM5LCJpYXQiOjE3MDgzOTg5MzksImp0aSI6ImRjODhhMzk1MzhiYTQwNTE5OGEyY2FhZWY1MDVmZjE1IiwidXNlcl9pZCI6Nn0.xnB5yPdlAqwt7s8LSgOlRYdHLXXKXb6Im8ggjxu9_AA";

class IssueDetailService {
  Future<List<IssueDetailModel>> getIssueDetail(int issueId) async {
    List<IssueDetailModel> dataInstance = [];

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
        final List<dynamic> data = jsonDecode(response.body);
        for (var d in data) {
          dataInstance.add(IssueDetailModel.fromJson(d));
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
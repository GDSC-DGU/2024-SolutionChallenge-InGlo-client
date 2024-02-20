import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inglo/models/issue_detail/issue_detail.dart';

const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NDE0NTYyLCJpYXQiOjE3MDg0MTA5NjIsImp0aSI6IjBhNzExYTkyNjU1MTRhYzk4NGI3N2ExODNhNjNkYTk0IiwidXNlcl9pZCI6Nn0.wDPOiwf-Yih1nEXNl_8blYqlOjPlzDVgkZzhJ7G8ogw";

class IssueDetailService {
  Future<IssueDetailModel> getIssueDetail(int issueId) async {
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
        final dynamic data = jsonDecode(response.body);
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
}
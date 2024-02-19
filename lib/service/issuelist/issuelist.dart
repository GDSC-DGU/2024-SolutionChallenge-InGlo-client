import 'dart:convert';

import 'package:inglo/models/issuelist/issue_top3.dart';
import 'package:http/http.dart' as http;

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
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4MzYwMTM2LCJpYXQiOjE3MDgzNTY1MzYsImp0aSI6ImZlZmQ0MTg2ZTA3NDQ0OWI4NTY4MzZlOTBlNzM1MzEzIiwidXNlcl9pZCI6Nn0.kx91-wPk-qRJ_9Nr926fy1pITqEfj2nfYdFjnuLzzUs',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
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

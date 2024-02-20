
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inglo/models/problem_definition/problem_definition.dart';
import 'package:http/http.dart' as http;
import 'package:inglo/screens/hmw/hmw_detail.dart';
import 'package:inglo/service/issue_detail/issue_detail.dart';


class ProblemDefinitionService {
  // 선택한 SDGs 관련 문제정의 조회
  Future<List<ProblemDefinitionModel>> getProblemDefinition(int sdgs) async {
    List<ProblemDefinitionModel> dataInstance = [];

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$sdgs/problem/");

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

      print("problem_definition: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var d in data) {
          dataInstance.add(ProblemDefinitionModel.fromJson(d));
        }

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

  // 선택한 SDGs 관련 문제정의 작성
  Future<void> postProblemDefinition(int sdgs, String content, BuildContext context) async {

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$sdgs/problem/");
    print("body: ${content}");
    try {
      final http.Response response = await http.post(
        coreUrl,
        headers: {
          //'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
          'Bearer $token',
        },
        body: {
          "content": content,
        }
      );

      print("problem_definition_write: ${response.body}");
      if (response.statusCode == 201) {
        print("성공");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HMWDetailPage(sdgs: sdgs),
          ),
        );
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inglo/models/problem_definition/problem_definition.dart';
import 'package:http/http.dart' as http;
import 'package:inglo/screens/hmw/hmw_detail.dart';
import 'package:inglo/screens/problem_definition/problem_definition.dart';
import 'package:inglo/service/issue/issue_detail.dart';


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
        // 화면 전환 어케 했는지 물어보깅!
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProblemDefinitionPage(sdgs: sdgs),
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

  // problem definition 선택
  Future<void> postProblemChoose(int sdgs, int problemId, BuildContext context) async {

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/");

    if(problemId == 0) {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            title: Text("Problem Choose"),
            content: Text("Please Choose one problem definition."),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //창 닫기
                  },
                  child: Text("Confirm"),
                ),
              ),
            ],
          );
        }),
      );
    }


    try {
      final http.Response response = await http.post(
          coreUrl,
          headers: {
            'Accept': 'application/json',
            'Authorization':
            'Bearer $token',
          },
          body: {
            "problem_id": problemId.toString(),
          }
      );

      print("problem_definition_choose: ${response.body}");
      if (response.statusCode == 201) {
        print("성공");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HMWDetailPage(sdgs: sdgs, problemId: problemId,),
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
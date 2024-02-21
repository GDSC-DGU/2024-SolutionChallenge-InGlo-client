import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inglo/models/design/crazy.dart';
import 'package:http/http.dart' as http;
import 'package:inglo/screens/crazy/crazy_8s.dart';
import 'package:inglo/service/issue/issue_detail.dart';

class CrazyService {
  // 내가 작성한 Crazy 조회
  Future<CrazyMineModel> getCrazyMine(int problemId) async {
    CrazyMineModel dataInstance;
    print("getCrazyMine: $problemId");
    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId/crazy8/my/");

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

      print("crazy_mine: ${response.body}");
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        dataInstance = CrazyMineModel.fromJson(data);

        return dataInstance;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
// 예외 처리
      print('Exception caught: $e');
    }

    throw Error();
  }

  // 전체 Crazy 조회
  Future<List<CrazyAllModel>> getCrazyAll(int problemId) async {
    List<CrazyAllModel> dataInstance = [];

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId/crazy8/");

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

      print("crazy_all: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        for (var d in data) {
          dataInstance.add(CrazyAllModel.fromJson(d));
        }

        return dataInstance;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }

    throw Error();
  }

  // Crazy 작성
  Future<void> postCrazy(int sdgs, int problemId, String content, BuildContext context) async {
    print("postCrazy: $problemId");
    print("content: $content");
    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId/crazy8/");

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

      print("crazy_write: ${response.body}");
      if (response.statusCode == 201) {
        print("성공");

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                Crazy8sPage(sdgs: sdgs, problemId: problemId,),
          ),
        );
      } else if (response.statusCode == 400){
        return showDialog(
          context: context,
          barrierDismissible: true,
          builder: ((context) {
            return AlertDialog(
              title: Text("Write Crazy 8's"),
              content: Text("Please Write 1~8 Crazy 8's"),
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
      } else {
        print('statusCode: ${response.statusCode}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }

    throw Error();
  }

  // Crazy 선택
  Future<void> postCrazyChoose(int problemId, int crazy8contentId, BuildContext context, changeIsChecked, changeCheck) async {

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId/crazy8/vote/");

    if(problemId == 0) {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            title: Text("Crazy 8's Choose"),
            content: Text("Please Choose one Crazy 8's."),
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
            "crazy8content_id": crazy8contentId.toString(),
          }
      );

      print("crazy_choose: ${response.body}");
      if (response.statusCode == 201) {
        print("성공");
        // 함수 넣기
        changeCheck();
        changeIsChecked();
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
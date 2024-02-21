
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inglo/models/design/hmw_model.dart';
import 'package:inglo/screens/crazy/crazy_8s.dart';
import 'package:inglo/screens/hmw/hmw_detail.dart';
import 'package:http/http.dart' as http;

class HMWService {
  // hmw 조회
  Future<HMWModel> getHmw(int problemId, String? token) async {
    HMWModel dataInstance;

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId/hmw/");

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

      print("hmw_list: ${response.body}");
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        dataInstance = HMWModel.fromJson(data);

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

  // hmw 생성
  // 선택한 SDGs 관련 문제정의 작성
  Future<void> postHMW(int sdgs, int problemId, String content, BuildContext context, String? token) async {

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId/hmw/");
    print("content: $content");

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

      print("hmw_write: ${response.body}");
      if (response.statusCode == 201) {
        print("성공");
        // 화면 전환
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

  // hmw 선택
  Future<void> patchHMW(int sdgs, int problemId, int hmwId, BuildContext context, String? token) async {

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId/hmw/");

    if(hmwId == 0) {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            title: Text("HMW Choose"),
            content: Text("Please Choose one HMW."),
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
      final http.Response response = await http.patch(
          coreUrl,
          headers: {
            'Accept': 'application/json',
            'Authorization':
            'Bearer $token',
          },
          body: {
            "hmw_id": hmwId.toString(),
          }
      );

      print("hmw_choose: ${response.body}");
      if (response.statusCode == 201) {
        print("성공");
        // 화면 전환
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Crazy8sPage(sdgs: sdgs, problemId: problemId),
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
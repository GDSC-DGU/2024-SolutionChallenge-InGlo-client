import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inglo/screens/postlist/post_board.dart';

class SolutionSketchService {
  // 솔루션 스케치 작성
  Future<void> patchSolutionSketch(
      int problemId,
      File image,
      String title,
      String description,
      String content,
      BuildContext context,
      String? token) async {
    if (image == null || title == "" || description == "" || content == "") {
      // alert창 띄워
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            title: Text("Solution Sketch"),
            content: Text("Please fill out all fields."),
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
      final dio = Dio();
      String fileName = image!.path.split('/').last;

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image!.path, filename: fileName),
        "title": title,
        "description": description,
        "content": content,
      });

      dio.options.headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token', // 필요한 토큰이나 인증 정보를 여기에 추가
      };

      var response = await dio.patch(
        "https://dongkyeom.com/api/v1/sketches/$problemId",
        data: formData,
      );

      print("solution_sketch: ${response.data}");
      if (response.statusCode == 201) {
        print("성공");

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostBoardPage(),
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

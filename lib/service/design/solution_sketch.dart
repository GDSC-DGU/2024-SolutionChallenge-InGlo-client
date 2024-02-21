import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inglo/screens/postlist/post_board.dart';
import 'package:inglo/service/issue/issue_detail.dart';

class SolutionSketchService {
  // 솔루션 스케치 작성
  Future<void> patchSolutionSketch(int problemId, File image, String title,
      String description, String content, BuildContext context) async {
    final coreUrl =
        Uri.parse("https://dongkyeom.com/api/v1/sketches/$problemId");

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

      var request = new http.MultipartRequest("PATCH", coreUrl);

      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['content'] = content;
      request.files.add(await http.MultipartFile.fromPath('image', image.path));


      var response = await request.send();

      // final http.Response response = await http.patch(coreUrl, headers: {
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // }, body: {
      //   "image": image,
      //   "title": title,
      //   "description": description,
      //   "content": content,
      // });

      print("solution_sketch: $response");
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

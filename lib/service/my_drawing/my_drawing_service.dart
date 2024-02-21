import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inglo/models/my_drawing/my_drawing_model.dart';

class MyDrawingService {
  // 내 솔루션 스케치 리스트 조회
  Future<List<MyDrawingListModel>> getMyDrawingList(String? token) async {
    List<MyDrawingListModel> dataInstance = [];

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/");

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

      print("my_drawing_list: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var d in data) {
          dataInstance.add(MyDrawingListModel.fromJson(d));
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

  // 솔루션 스케치 상세 보기
  Future<MyDrawingDetailModel> getMyDrawingDetail(int sketchId, String? token) async {
    MyDrawingDetailModel dataInstance;

    final coreUrl =
    Uri.parse("https://dongkyeom.com/api/v1/sketches/detail/$sketchId");

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

      print("my_drawing_detail: ${response.body}");
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        dataInstance = MyDrawingDetailModel.fromJson(data);

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
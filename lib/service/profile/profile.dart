import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:provider/provider.dart';
import 'package:inglo/provider/profile/users.dart';

class ProfileService {
  final Dio dio = Dio(); // Dio 인스턴스 생성

  // profile get 함수
  Future<User> getProfile(String? _token, BuildContext context) async {
    final url = "https://dongkyeom.com/api/v1/accounts/info/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer $_token',
          },
        ),
      );

      String responseBody = response.data;
      print('data : ${response.data}');

      User user = parseUser(responseBody); // 받아온 데이터를 User 객체로 생성
      print('user : $user');
      // 굳이 필요 없을 것 같기도..
      updateSpecificUserInfo(context, user); // 전체 업데이트

      return user;
    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
      throw Exception('Failed to load user profile');
    }
  }

  // 전체 update 함수
  void updateSpecificUserInfo(BuildContext context, User newUser) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.updateUser(newUser);
  }
}

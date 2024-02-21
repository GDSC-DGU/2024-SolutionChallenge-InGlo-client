import 'package:dio/dio.dart';
import 'package:inglo/screens/start/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inglo/provider/profile/users.dart';
import 'dart:convert';

class UserAuthService {
  final Dio dio = Dio(); // Dio 인스턴스 생성
  static final storage = FlutterSecureStorage();

  // feedback 받아오기
  Future<void> getUserAuth(String? token, BuildContext context) async {
    final url = "https://dongkyeom.com/api/v1/accounts/info/semi/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('유저 인증 정보 받아오기 성공! ${response.data}');
        Map<String, dynamic> userData = jsonDecode(response.data);

        Provider.of<UserProvider>(context, listen: false).updateUserIdField(
            id: userData['id'], // 받아온 아이디 값
            name: userData['name'], // 받아온 이름 값
            profile_img: userData['profile_img'] // 받아온 프로필 이미지 URL
        );
      } else {
        print('code : ${response.statusCode} data : ${response.data}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // 만료된 토큰 발급 함수 혹시 모르니 보류
  Future<dynamic> GetNewToken(String? refresh_token, onTokenRefreshed, BuildContext context) async {
    print('refresh : ${refresh_token}');
    final url = "https://dongkyeom.com/api/v1/accounts/token/refresh/";
    Map<String, String> data = {
      "refresh": '${refresh_token}',
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
    );

    try {
      final response = await dio.post(url, data: data, options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 성공
        print(
            '리프레시 성공!: ${response.statusCode}, 새 토큰: ${response.data['access']}');

        // 새 토큰을 provider에 저장
        onTokenRefreshed(response.data['access']); // 콜백 함수
      } else if (response.statusCode == 401) {
        // refresh token 발급 필요, 토큰 삭제 후 로그인 페이지로 이동한다.
        await storage.delete(key: 'refresh_token');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StartPage()));
      } else {
        print(
            'Error api code: ${response.statusCode}, response: ${response.data}');
        return false;
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
}

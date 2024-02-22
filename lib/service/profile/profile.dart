import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:image_picker/image_picker.dart';
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

  // 유저 정보 전송 API
  Future<void> PostUserInfo(String? _name, String? _country, String? _language, String? _token, BuildContext context) async {
    print('받은 값 : name : $_name country : $_country language : $_language');
    final url = "https://dongkyeom.com/api/v1/accounts/info/";
    Map<String, dynamic> data = {
      "name": _name,
      "country": int.parse('$_country'),
      "language": _language,
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
        'Bearer $_token',
      },
    );

    try {
      final response = await dio.patch(url, data: data, options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 성공
        print(
            'Success code: ${response.statusCode}, response: ${response.data}');
      } else {
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  // 이미지를 서버에 전송하는 함수
  Future<void> UploadImage(XFile? _image, String? _token, BuildContext context) async {
    print('이미지를 보냅니다!');
    if (_image == null) return;
    String fileName = _image.path.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(_image.path, filename: fileName),
      });

      dio.options.headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $_token', // 필요한 토큰이나 인증 정보를 여기에 추가
      };

      var response = await dio.patch(
        'https://dongkyeom.com/api/v1/accounts/info/profile-img/',
        data: formData,
      );

      print('업로드 성공 : ${response.statusCode}');

    } catch (e) {
      print('이미지 업로드 실패: $e');
    }
  }

}

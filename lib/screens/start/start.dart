import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:inglo/screens/issuelist/issulist.dart';
import 'package:inglo/screens/signup/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // secure

import 'dart:convert';
import 'package:dio/dio.dart';
// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/user_token/user_token.dart';

// LoginPage 클래스
class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final dio = Dio(); // dio instance 생성

  static final storage = FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  dynamic user_token = ''; // storage에 있는 유저 정보를 저장

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    user_token = await storage.read(key:'refresh_token');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어간다.
    if (user_token != null) {
      print('리프레시 인증 성공!');
      GetNewToken(user_token); // 새 토큰 발급
      // 여기 refresh token과 비교하여 token이 유효한지 확인한다.
    } else {
      print('로그인이 필요합니다');
    }
  }


  // 만료된 토큰 발급 함수
  Future<void> GetNewToken(String refresh_token) async {

    print('refresh : ${refresh_token}');
    final url = "https://dongkyeom.com/api/v1/accounts/token/refresh/";
    Map<String, String> data = {
      "refresh_token": 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwODU5MDIwMywiaWF0IjoxNzA4NTAzODAzLCJqdGkiOiIzM2YwZjNmNzA5YjE0Y2E0ODMzYjViY2ZlYzNjMjIwZSIsInVzZXJfaWQiOjN9.uhfeTninED9YvaccySNljTh74oly6rMjEjwkYxlSH94',
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
            'Success code: ${response.statusCode}, 새 토큰: ${response.data['access_token']}');

        // 새 토큰을 provider에 저장
        Provider.of<UserToken>(context, listen: false).setToken(response.data['access_token']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IssueListPage()), // 다음 페이지로 이동
        );
      } else {
        print('Error api code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  // google token 전송 api(500 출력 중)
  Future<void> PostApi(String _token) async {
    print('전송 토큰 $_token');

    final url = "https://dongkyeom.com/api/v1/accounts/loginsuccess/";
    Map<String, String> data = {
      "access_token": _token,
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
            'Success code: ${response.statusCode}, response: ${response.data['refresh_token']}');

        // storage에 저장
        await storage.write(
          key: 'refresh_token',
          value: response.data['refresh_token'], // 토큰 직렬화 데이터 저장
        );
        await storage.write(
          key: 'access_token',
          value: response.data['access_token'], // 토큰 직렬화 데이터 저장
        );

        // 새 토큰을 provider에 저장
        Provider.of<UserToken>(context, listen: false).setToken(response.data['access_token']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()), // 다음 페이지로 이동
        );

      } else {
        // 비-200 상태 코드
        print('Error api code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }
  }

  // id token 발급
  Future<String?> _handleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        print('id : ${googleAuth.idToken}'); // Google 로부터 받은 idToken
        PostApi(googleAuth.accessToken!);
      }
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      // 배경 이미지를 넣기 위해 Scaffold를 Container로 감싸준다.
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            repeat: ImageRepeat.noRepeat,
            image: Svg(
              'assets/image/background/background.svg',
              // size: Size(10, 10), // size 지정 하던 안 하던 동일하다.
            ),
          )),
      child: Scaffold(
        // 배경 이미지를 위해 Scaffold의 배경색을 투명으로 한다.
        backgroundColor: Colors.transparent,
        // 수직 스크롤이 된다고 한다.
        // 나중에 빼도 될 것 같다!
        body: SingleChildScrollView(
          child: Padding(
            // 전체 padding
            padding: const EdgeInsets.fromLTRB(60, 300, 60, 0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 160.0),
                  OutlinedButton(
                    onPressed: _handleSignIn,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white), // 버튼 배경색
                      minimumSize: MaterialStateProperty.all(Size(400, 40)), // 버튼 사이즈
                      // 테두리 색상 설정
                      side: MaterialStateProperty.all(BorderSide(color: Color(0xFFDADCE0), width: 1)),
                    ),
                    child: Text(
                      "SIGNIN WITH GOOGLE",
                      style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.black,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
